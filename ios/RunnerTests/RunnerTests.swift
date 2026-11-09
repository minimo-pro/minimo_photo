import Flutter
import Photos
import UIKit
import XCTest
@testable import Runner

class RunnerTests: XCTestCase {
  func testReplacementReachesWriterWithoutSourceOrCachedMetadata() throws {
    let image = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { context in
      UIColor.red.setFill()
      context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    let url = FileManager.default.temporaryDirectory
      .appendingPathComponent(UUID().uuidString)
      .appendingPathExtension("jpg")
    try XCTUnwrap(image.jpegData(compressionQuality: 1)).write(to: url)
    defer { try? FileManager.default.removeItem(at: url) }

    let saved = expectation(description: "Replacement reached native writer")
    let delegate = SceneDelegate()
    delegate.requestReplacementAuthorization = { level, completion in
      XCTAssertEqual(level, .addOnly)
      completion(.authorized)
    }
    delegate.replacementWriterForTesting = { metadata, result in
      XCTAssertNil(metadata.creationDate)
      XCTAssertNil(metadata.location)
      result(["saved": true, "warnings": []])
    }
    delegate.saveReplacement([
      "path": url.path,
      "sourceIdentifier": UUID().uuidString,
    ]) { result in
      XCTAssertEqual((result as? [String: Any])?["saved"] as? Bool, true)
      saved.fulfill()
    }
    wait(for: [saved], timeout: 10)
  }

  func testSharedPhotoInboxPublishesCompleteRequest() throws {
    let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
    let inbox = root.appendingPathComponent("inbox")
    let source = root.appendingPathComponent("source.jpg")
    try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
    try Data([1, 2, 3]).write(to: source)
    defer { try? FileManager.default.removeItem(at: root) }

    _ = try SharedPhotoInbox.stage(urls: [source], source: "test", preset: "high", root: inbox)
    let (request, directory) = try XCTUnwrap(SharedPhotoInbox.next(root: inbox))

    XCTAssertEqual(request.preset, "high")
    XCTAssertTrue(FileManager.default.fileExists(atPath: directory.appendingPathComponent("manifest.json").path))
    XCTAssertTrue(FileManager.default.fileExists(atPath: directory.appendingPathComponent(request.files[0]).path))
  }
}
