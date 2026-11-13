import CoreLocation
import Flutter
import ImageIO
import Photos
import PhotosUI
import UIKit
import UniformTypeIdentifiers

struct PickedPhotoMetadata {
  let creationDate: Date?
  let location: CLLocation?

  var isAvailable: Bool {
    creationDate != nil || location != nil
  }
}

class SceneDelegate: FlutterSceneDelegate, PHPickerViewControllerDelegate, UIDocumentPickerDelegate {
  private var pendingPickResult: FlutterResult?
  private var activePickID: UUID?
  private var copyingPhotos = false
  private var photosChannel: FlutterMethodChannel?
  private var externalPhotosChannel: FlutterMethodChannel?
  var requestReplacementAuthorization:
    (PHAccessLevel, @escaping (PHAuthorizationStatus) -> Void) -> Void = {
      level, completion in PHPhotoLibrary.requestAuthorization(for: level, handler: completion)
    }
  var replacementWriterForTesting: ((PickedPhotoMetadata, @escaping FlutterResult) -> Void)?
  var performPhotoCreation:
    (@escaping () -> Void, @escaping (Bool, Error?) -> Void) -> Void = {
      changes, completion in
      PHPhotoLibrary.shared().performChanges(changes, completionHandler: completion)
    }

  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    guard let controller = window?.rootViewController as? FlutterViewController else { return }

    let channel = FlutterMethodChannel(
      name: "minimo_photo/photos",
      binaryMessenger: controller.binaryMessenger
    )
    photosChannel = channel
    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "pickPhotos":
        let source = (call.arguments as? [String: Any])?["source"] as? String ?? "gallery"
        self.pickPhotos(source: source, result: result)
      case "cancelPhotoPick":
        self.cancelPhotoPick(result: result)
      case "deleteOriginals":
        self.deleteOriginals(call.arguments as? [String] ?? [], result: result)
      case "saveReplacement":
        self.saveReplacement(call.arguments as? [String: Any], result: result)
      case "saveCopy":
        self.saveCopy(call.arguments as? [String: Any], result: result)
      case "removeLocation":
        self.removeLocation(call.arguments as? String, result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    let externalChannel = FlutterMethodChannel(
      name: "minimo_photo/external_photos",
      binaryMessenger: controller.binaryMessenger
    )
    externalPhotosChannel = externalChannel
    externalChannel.setMethodCallHandler { call, result in
      switch call.method {
      case "consumeExternalPhotos": self.consumeExternalPhotos(result: result)
      default: result(FlutterMethodNotImplemented)
      }
    }
    if connectionOptions.urlContexts.contains(where: { $0.url.scheme == "minimophoto" }) {
      externalChannel.invokeMethod("externalPhotosAvailable", arguments: nil)
    }
  }

  override func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    super.scene(scene, openURLContexts: URLContexts)
    if URLContexts.contains(where: { $0.url.scheme == "minimophoto" }) {
      externalPhotosChannel?.invokeMethod("externalPhotosAvailable", arguments: nil)
    }
  }

  override func sceneDidBecomeActive(_ scene: UIScene) {
    super.sceneDidBecomeActive(scene)
    externalPhotosChannel?.invokeMethod("externalPhotosAvailable", arguments: nil)
  }

  private func consumeExternalPhotos(result: @escaping FlutterResult) {
    DispatchQueue.global(qos: .userInitiated).async {
      do {
        guard let (request, directory) = try SharedPhotoInbox.next() else {
          return DispatchQueue.main.async { result(nil) }
        }
        var photos: [[String: Any]] = []
        do {
          for name in request.files {
            let input = directory.appendingPathComponent(name)
            let output = try self.copyPickedPhoto(from: input, filename: name)
            photos.append(["path": output.path, "name": name, "size": (try? output.resourceValues(forKeys: [.fileSizeKey]).fileSize) ?? 0])
          }
          SharedPhotoInbox.remove(directory)
          DispatchQueue.main.async { result(["preset": request.preset, "files": photos]) }
        } catch {
          for photo in photos {
            if let path = photo["path"] as? String { try? FileManager.default.removeItem(atPath: path) }
          }
          SharedPhotoInbox.remove(directory)
          throw error
        }
      } catch {
        DispatchQueue.main.async { result(FlutterError(code: "external_import_failed", message: error.localizedDescription, details: nil)) }
      }
    }
  }

  private func pickPhotos(source: String, result: @escaping FlutterResult) {
    guard pendingPickResult == nil else {
      result(FlutterError(
        code: "pick_in_progress",
        message: "photo picker is already open",
        details: nil
      ))
      return
    }
    pendingPickResult = result
    activePickID = UUID()
    source == "files" ? presentDocumentPicker() : presentPhotosPicker()
  }

  private func cancelPhotoPick(result: @escaping FlutterResult) {
    let cancelledResult = pendingPickResult
    if !copyingPhotos { pendingPickResult = nil }
    activePickID = nil
    window?.rootViewController?.presentedViewController?.dismiss(animated: true)
    if !copyingPhotos { cancelledResult?([]) }
    result(nil)
  }

  private func presentPhotosPicker() {
    var configuration = PHPickerConfiguration(photoLibrary: .shared())
    configuration.filter = .images
    configuration.selectionLimit = 0
    configuration.preferredAssetRepresentationMode = .current

    let picker = PHPickerViewController(configuration: configuration)
    picker.delegate = self
    window?.rootViewController?.present(picker, animated: true)
  }

  private func presentDocumentPicker() {
    let picker = UIDocumentPickerViewController(
      forOpeningContentTypes: [.image],
      asCopy: true
    )
    picker.allowsMultipleSelection = true
    picker.delegate = self
    window?.rootViewController?.present(picker, animated: true)
  }

  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    guard let pendingPickResult, let pickID = activePickID else { return }

    guard !results.isEmpty else {
      activePickID = nil
      self.pendingPickResult = nil
      pendingPickResult([])
      return
    }

    photosChannel?.invokeMethod(
      "pickProgress", arguments: ["processed": 0, "total": results.count]
    )

    copyingPhotos = true
    let group = DispatchGroup()
    let lock = NSLock()
    var photos: [(Int, [String: Any])] = []
    var processed = 0

    for (index, item) in results.enumerated() {
      group.enter()
      let filename = originalFilename(for: item) ?? suggestedFilename(for: item)
      item.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) {
        [weak self] url, error in
        defer {
          lock.lock()
          processed += 1
          let completed = processed
          lock.unlock()
          DispatchQueue.main.async {
            guard self?.activePickID == pickID else { return }
            self?.photosChannel?.invokeMethod(
              "pickProgress", arguments: ["processed": completed, "total": results.count]
            )
          }
          group.leave()
        }
        guard let self, error == nil, let url else { return }

        do {
          let source = item.assetIdentifier.flatMap {
            self.photosAssetIfAccessible(identifier: $0)
          }
          let fallback = self.imageMetadata(at: url)
          let metadata = source.map {
            PickedPhotoMetadata(creationDate: $0.creationDate, location: $0.location)
          } ?? fallback
          let output = try self.copyPickedPhoto(from: url, filename: filename)
          let size = (try? output.resourceValues(forKeys: [.fileSizeKey]).fileSize) ?? 0
          var photo: [String: Any] = [
            "path": output.path,
            "name": filename,
            "size": size,
          ]
          if let identifier = item.assetIdentifier {
            photo["sourceIdentifier"] = identifier
            photo["canDeleteOriginal"] = source != nil
            photo["canPreserveMetadata"] = source != nil || metadata.isAvailable
          }
          if let date = metadata.creationDate {
            photo["captureDate"] = ISO8601DateFormatter().string(from: date)
          }
          if let location = metadata.location {
            photo["latitude"] = location.coordinate.latitude
            photo["longitude"] = location.coordinate.longitude
          }
          lock.lock()
          photos.append((index, photo))
          lock.unlock()
        } catch {}
      }
    }

    group.notify(queue: .main) {
      self.copyingPhotos = false
      guard self.activePickID == pickID else {
        for (_, photo) in photos {
          if let path = photo["path"] as? String {
            try? FileManager.default.removeItem(atPath: path)
          }
        }
        self.pendingPickResult = nil
        pendingPickResult([])
        return
      }
      self.activePickID = nil
      self.pendingPickResult = nil
      pendingPickResult(photos.sorted { $0.0 < $1.0 }.map { $0.1 })
    }
  }

  func documentPicker(
    _ controller: UIDocumentPickerViewController,
    didPickDocumentsAt urls: [URL]
  ) {
    guard let pendingPickResult, let pickID = activePickID else { return }

    photosChannel?.invokeMethod(
      "pickProgress", arguments: ["processed": 0, "total": urls.count]
    )

    copyingPhotos = true
    DispatchQueue.global(qos: .userInitiated).async {
      var photos: [[String: Any]] = []
      for (index, url) in urls.enumerated() {
        do {
          let name = url.lastPathComponent.isEmpty ? "photo.jpg" : url.lastPathComponent
          let output = try self.copyPickedPhoto(from: url, filename: name)
          let size = (try? output.resourceValues(forKeys: [.fileSizeKey]).fileSize) ?? 0
          photos.append(["path": output.path, "name": name, "size": size])
        } catch {}
        DispatchQueue.main.async {
          guard self.activePickID == pickID else { return }
          self.photosChannel?.invokeMethod(
            "pickProgress", arguments: ["processed": index + 1, "total": urls.count]
          )
        }
      }
      DispatchQueue.main.async {
        self.copyingPhotos = false
        guard self.activePickID == pickID else {
          for photo in photos {
            if let path = photo["path"] as? String {
              try? FileManager.default.removeItem(atPath: path)
            }
          }
          self.pendingPickResult = nil
          pendingPickResult([])
          return
        }
        self.activePickID = nil
        self.pendingPickResult = nil
        pendingPickResult(photos)
      }
    }
  }

  func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    guard let pendingPickResult else { return }
    self.pendingPickResult = nil
    activePickID = nil
    pendingPickResult([])
  }

  private func deleteOriginals(_ identifiers: [String], result: @escaping FlutterResult) {
    guard !identifiers.isEmpty else {
      result(FlutterError(
        code: "delete_unavailable",
        message: "no Photos assets to delete",
        details: nil
      ))
      return
    }

    PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
      guard status == .authorized || status == .limited else {
        DispatchQueue.main.async {
          result(FlutterError(
            code: "delete_denied",
            message: "Photos access was denied",
            details: nil
          ))
        }
        return
      }
      let assets = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
      guard assets.count == identifiers.count else {
        DispatchQueue.main.async {
          result(FlutterError(
            code: "delete_unavailable",
            message: "some original photos are unavailable",
            details: nil
          ))
        }
        return
      }
      PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.deleteAssets(assets)
      }) { success, error in
        DispatchQueue.main.async {
          if success {
            result(assets.count)
          } else {
            result(FlutterError(
              code: "delete_failed",
              message: error?.localizedDescription ?? "original photos were not deleted",
              details: nil
            ))
          }
        }
      }
    }
  }

  private func removeLocation(_ path: String?, result: @escaping FlutterResult) {
    guard let path else {
      result(FlutterError(code: "metadata_failed", message: "photo path is missing", details: nil))
      return
    }
    DispatchQueue.global(qos: .userInitiated).async {
      let url = URL(fileURLWithPath: path)
      let temporary = url.deletingLastPathComponent()
        .appendingPathComponent(UUID().uuidString)
      do {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
              let type = CGImageSourceGetType(source),
              let destination = CGImageDestinationCreateWithURL(
                temporary as CFURL, type, 1, nil
              ) else {
          throw NSError(domain: "minimo_photo", code: 2)
        }
        guard CGImageDestinationCopyImageSource(
          destination, source,
          [
            // ImageIO requires metadata when merging existing tags.
            kCGImageDestinationMetadata: CGImageMetadataCreateMutable(),
            kCGImageMetadataShouldExcludeGPS: true,
            kCGImageDestinationMergeMetadata: true,
          ] as CFDictionary, nil
        ) else {
          throw NSError(domain: "minimo_photo", code: 3)
        }
        _ = try FileManager.default.replaceItemAt(url, withItemAt: temporary)
        DispatchQueue.main.async { result(nil) }
      } catch {
        try? FileManager.default.removeItem(at: temporary)
        DispatchQueue.main.async {
          result(FlutterError(
            code: "metadata_failed", message: error.localizedDescription, details: nil
          ))
        }
      }
    }
  }

  func saveReplacement(
    _ arguments: [String: Any]?,
    result: @escaping FlutterResult
  ) {
    let trace = "[photo-save][\(UUID().uuidString)]"
    let result = tracedSaveResult("replacement", arguments: arguments, trace: trace, result: result)
    guard
      let path = arguments?["path"] as? String,
      let sourceIdentifier = arguments?["sourceIdentifier"] as? String,
      FileManager.default.fileExists(atPath: path)
    else {
      result(FlutterError(
        code: "save_failed",
        message: "replacement photo is unavailable",
        details: nil
      ))
      return
    }

    let fallback = pickedMetadata(from: arguments)
    let source = photosAssetIfAccessible(identifier: sourceIdentifier)
    let accessLevel: PHAccessLevel = source == nil ? .addOnly : .readWrite
    NSLog("%@ sourceAccessible=%@ authorization requested=%ld", trace, String(source != nil), accessLevel.rawValue)
    requestReplacementAuthorization(accessLevel) { status in
      NSLog("%@ authorization returned=%ld", trace, status.rawValue)
      guard status == .authorized || status == .limited else {
        DispatchQueue.main.async {
          result(FlutterError(
            code: "save_denied",
            message: "Photos access was denied",
            details: nil
          ))
        }
        return
      }

      var albums: [PHAssetCollection] = []
      var skippedSourceAlbum = false
      if let source {
        let sourceAlbums = PHAssetCollection.fetchAssetCollectionsContaining(
          source,
          with: .album,
          options: nil
        )
        sourceAlbums.enumerateObjects { collection, _, _ in
          if collection.canPerform(.addContent) { albums.append(collection) }
        }
        skippedSourceAlbum = albums.count < sourceAlbums.count
      }

      let requestedAlbum = (arguments?["album"] as? String)?
        .trimmingCharacters(in: .whitespacesAndNewlines)
      self.ensureAlbum(named: requestedAlbum, trace: trace) { album, albumWarning in
        let metadata = source.map {
          PickedPhotoMetadata(creationDate: $0.creationDate, location: $0.location)
        } ?? fallback
        if let album, !albums.contains(where: {
          $0.localIdentifier == album.localIdentifier
        }) {
          albums.append(album)
        }
        let replacementMetadata = PickedPhotoMetadata(
          creationDate: metadata.creationDate,
          location: arguments?["removeLocation"] as? Bool == true ? nil : metadata.location
        )
        if let replacementWriterForTesting = self.replacementWriterForTesting {
          replacementWriterForTesting(replacementMetadata, result)
          return
        }
        self.createReplacement(
          at: URL(fileURLWithPath: path),
          metadata: replacementMetadata,
          albums: albums,
          favorite: source?.isFavorite ?? false,
          initialWarnings: albumWarning || skippedSourceAlbum
            ? ["album_unavailable"]
            : [],
          trace: trace,
          result: result
        )
      }
    }
  }

  /// Photos dates imports by their EXIF capture time, so an explicit date keeps
  /// the copy at the end of the library instead of next to the original.
  private func saveCopy(
    _ arguments: [String: Any]?,
    result: @escaping FlutterResult
  ) {
    let trace = "[photo-save][\(UUID().uuidString)]"
    let result = tracedSaveResult("copy", arguments: arguments, trace: trace, result: result)
    guard
      let path = arguments?["path"] as? String,
      FileManager.default.fileExists(atPath: path)
    else {
      result(FlutterError(
        code: "save_failed",
        message: "compressed photo is unavailable",
        details: nil
      ))
      return
    }

    let requestedAlbum = (arguments?["album"] as? String)?
      .trimmingCharacters(in: .whitespacesAndNewlines)
    let accessLevel: PHAccessLevel =
      requestedAlbum?.isEmpty == false ? .readWrite : .addOnly
    NSLog("%@ authorization requested=%ld", trace, accessLevel.rawValue)
    PHPhotoLibrary.requestAuthorization(for: accessLevel) { status in
      NSLog("%@ authorization returned=%ld", trace, status.rawValue)
      guard status == .authorized || status == .limited else {
        DispatchQueue.main.async {
          result(FlutterError(
            code: "save_denied",
            message: "Photos access was denied",
            details: nil
          ))
        }
        return
      }

      self.ensureAlbum(named: requestedAlbum, trace: trace) { album, albumWarning in
        self.createReplacement(
          at: URL(fileURLWithPath: path),
          metadata: PickedPhotoMetadata(creationDate: Date(), location: nil),
          albums: album.map { [$0] } ?? [],
          favorite: false,
          initialWarnings: albumWarning ? ["album_unavailable"] : [],
          trace: trace,
          result: result
        )
      }
    }
  }

  func createReplacement(
    at url: URL,
    metadata: PickedPhotoMetadata,
    albums: [PHAssetCollection],
    favorite: Bool,
    initialWarnings: [String],
    trace: String,
    result: @escaping FlutterResult
  ) {
    NSLog("%@ Photos commit start albums=%ld date=%@ location=%@ favorite=%@", trace,
          albums.count, String(metadata.creationDate != nil), String(metadata.location != nil), String(favorite))
    performPhotoCreation({
      let request = PHAssetCreationRequest.forAsset()
      request.addResource(with: .photo, fileURL: url, options: nil)
      request.creationDate = metadata.creationDate
      if let location = metadata.location { request.location = location }
      request.isFavorite = favorite
      let placeholder = request.placeholderForCreatedAsset
      if let placeholder {
        for album in albums {
          PHAssetCollectionChangeRequest(for: album)?.addAssets([placeholder] as NSArray)
        }
      }
    }) { success, error in
      NSLog("%@ Photos commit completed success=%@ error=%@", trace,
            String(success), String(describing: error.map { $0 as NSError }))
      guard success else {
        DispatchQueue.main.async {
          result(FlutterError(
            code: "save_failed",
            message: error?.localizedDescription ?? "replacement photo was not saved",
            details: error.map { self.photoErrorDetails($0 as NSError) }
          ))
        }
        return
      }

      // A successful commit confirms the save; readback can omit a new asset.
      DispatchQueue.main.async {
        result(["saved": true, "warnings": initialWarnings])
      }
    }
  }

  private func ensureAlbum(
    named name: String?,
    trace: String,
    completion: @escaping (PHAssetCollection?, Bool) -> Void
  ) {
    guard let name, !name.isEmpty else {
      completion(nil, false)
      return
    }
    let collections = PHAssetCollection.fetchAssetCollections(
      with: .album,
      subtype: .any,
      options: nil
    )
    var existing: PHAssetCollection?
    collections.enumerateObjects { collection, _, stop in
      if collection.localizedTitle == name {
        existing = collection
        stop.pointee = true
      }
    }
    if let existing {
      NSLog("%@ album found", trace)
      completion(existing, false)
      return
    }

    var identifier: String?
    NSLog("%@ album creation start", trace)
    PHPhotoLibrary.shared().performChanges({
      identifier = PHAssetCollectionChangeRequest
        .creationRequestForAssetCollection(withTitle: name)
        .placeholderForCreatedAssetCollection
        .localIdentifier
    }) { success, error in
      NSLog("%@ album creation completed success=%@ error=%@", trace,
            String(success), String(describing: error.map { $0 as NSError }))
      guard success, let identifier else {
        completion(nil, true)
        return
      }
      completion(
        PHAssetCollection.fetchAssetCollections(
          withLocalIdentifiers: [identifier],
          options: nil
        ).firstObject,
        false
      )
    }
  }

  private func tracedSaveResult(
    _ mode: String,
    arguments: [String: Any]?,
    trace: String,
    result: @escaping FlutterResult
  ) -> FlutterResult {
    let started = ProcessInfo.processInfo.systemUptime
    let path = arguments?["path"] as? String ?? ""
    let attributes = try? FileManager.default.attributesOfItem(atPath: path)
    let storage = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
    NSLog("%@ start mode=%@ os=%@ extension=%@ readable=%@ bytes=%@ freeBytes=%@ album=%@ readWrite=%ld addOnly=%ld", trace,
          mode, UIDevice.current.systemVersion, URL(fileURLWithPath: path).pathExtension,
          String(FileManager.default.isReadableFile(atPath: path)),
          String(describing: attributes?[.size]), String(describing: storage?[.systemFreeSize]),
          String(arguments?["album"] is String),
          PHPhotoLibrary.authorizationStatus(for: .readWrite).rawValue,
          PHPhotoLibrary.authorizationStatus(for: .addOnly).rawValue)
    return { value in
      let elapsed = Int((ProcessInfo.processInfo.systemUptime - started) * 1000)
      if let error = value as? FlutterError {
        NSLog("%@ failed elapsedMs=%ld code=%@ message=%@ details=%@", trace, elapsed,
              error.code, error.message ?? "", String(describing: error.details))
      } else {
        NSLog("%@ completed elapsedMs=%ld result=%@", trace, elapsed, String(describing: value))
      }
      result(value)
    }
  }

  private func photoErrorDetails(_ error: NSError) -> [String: Any] {
    var details: [String: Any] = [
      "domain": error.domain,
      "code": error.code,
      "description": error.localizedDescription,
    ]
    if let underlying = error.userInfo[NSUnderlyingErrorKey] as? NSError {
      details["underlying"] = photoErrorDetails(underlying)
    }
    return details
  }

  private func imageMetadata(at url: URL) -> PickedPhotoMetadata {
    guard
      let source = CGImageSourceCreateWithURL(url as CFURL, nil),
      let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil)
        as? [CFString: Any]
    else {
      return PickedPhotoMetadata(creationDate: nil, location: nil)
    }

    var creationDate: Date?
    if
      let exif = properties[kCGImagePropertyExifDictionary] as? [CFString: Any],
      let value = exif[kCGImagePropertyExifDateTimeOriginal] as? String
    {
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "en_US_POSIX")
      formatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
      creationDate = formatter.date(from: value)
    }

    var location: CLLocation?
    if let gps = properties[kCGImagePropertyGPSDictionary] as? [CFString: Any] {
      let latitude = (gps[kCGImagePropertyGPSLatitude] as? NSNumber)?.doubleValue
      let longitude = (gps[kCGImagePropertyGPSLongitude] as? NSNumber)?.doubleValue
      if let latitude, let longitude {
        let latitudeRef = gps[kCGImagePropertyGPSLatitudeRef] as? String
        let longitudeRef = gps[kCGImagePropertyGPSLongitudeRef] as? String
        location = CLLocation(
          latitude: latitudeRef == "S" ? -latitude : latitude,
          longitude: longitudeRef == "W" ? -longitude : longitude
        )
      }
    }
    return PickedPhotoMetadata(creationDate: creationDate, location: location)
  }

  private func pickedMetadata(from arguments: [String: Any]?) -> PickedPhotoMetadata {
    let creationDate = (arguments?["captureDate"] as? String).flatMap {
      ISO8601DateFormatter().date(from: $0)
    }
    let latitude = (arguments?["latitude"] as? NSNumber)?.doubleValue
    let longitude = (arguments?["longitude"] as? NSNumber)?.doubleValue
    let location: CLLocation?
    if
      let latitude,
      let longitude,
      (-90...90).contains(latitude),
      (-180...180).contains(longitude)
    {
      location = CLLocation(latitude: latitude, longitude: longitude)
    } else {
      location = nil
    }
    return PickedPhotoMetadata(creationDate: creationDate, location: location)
  }

  private func photosAssetIfAccessible(identifier: String) -> PHAsset? {
    PHAsset.fetchAssets(
      withLocalIdentifiers: [identifier],
      options: nil
    ).firstObject
  }

  private func originalFilename(for item: PHPickerResult) -> String? {
    guard let identifier = item.assetIdentifier else { return nil }
    let assets = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil)
    guard let asset = assets.firstObject else { return nil }
    return PHAssetResource.assetResources(for: asset).first?.originalFilename
  }

  private func suggestedFilename(for item: PHPickerResult) -> String {
    let name = item.itemProvider.suggestedName ?? "photo"
    return name.contains(".") ? name : "\(name).jpg"
  }

  private func copyPickedPhoto(from source: URL, filename: String) throws -> URL {
    let directory = try cacheDirectory(named: "picked_photos")
    let safeName = sanitizeFilename(filename)
    let output = directory.appendingPathComponent("\(UUID().uuidString)_\(safeName)")
    do {
      try FileManager.default.copyItem(at: source, to: output)
    } catch {
      try? FileManager.default.removeItem(at: output)
      throw error
    }
    return output
  }

  private func cacheDirectory(named name: String) throws -> URL {
    guard let root = FileManager.default.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    ).first else {
      throw NSError(domain: "minimo_photo", code: 1)
    }
    let directory = root.appendingPathComponent(name, isDirectory: true)
    try FileManager.default.createDirectory(
      at: directory,
      withIntermediateDirectories: true
    )
    return directory
  }

  private func sanitizeFilename(_ value: String) -> String {
    let invalid = CharacterSet(charactersIn: "<>:\"/\\|?*")
      .union(.controlCharacters)
    let cleaned = value.components(separatedBy: invalid).joined(separator: "_")
    return cleaned.isEmpty ? "photo.jpg" : cleaned
  }
}
