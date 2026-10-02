import AppIntents
import UniformTypeIdentifiers

@available(iOS 16.0, *)
enum ShortcutPhotoPreset: String, AppEnum {
  case high, medium, low
  static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Quality")
  static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
    .high: "High", .medium: "Medium", .low: "Low"
  ]
}

@available(iOS 16.0, *)
struct CompressPhotosIntent: AppIntent {
  static let title: LocalizedStringResource = "Compress Photos in minimo"
  static let description = IntentDescription("Open selected photos in minimo for compression.")
  static let openAppWhenRun = true

  @Parameter(title: "Photos")
  var photos: [IntentFile]

  @Parameter(title: "Quality", default: .medium)
  var preset: ShortcutPhotoPreset

  func perform() async throws -> some IntentResult {
    let urls = photos.compactMap(\.fileURL)
    _ = try SharedPhotoInbox.stage(urls: urls, source: "shortcut", preset: preset.rawValue)
    return .result()
  }
}

@available(iOS 16.0, *)
struct MinimoPhotoShortcuts: AppShortcutsProvider {
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: CompressPhotosIntent(),
      phrases: ["Compress photos in \(.applicationName)"],
      shortTitle: "Compress Photos",
      systemImageName: "photo.badge.minus"
    )
  }
}
