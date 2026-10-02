import Flutter
import UIKit
import XCTest
@testable import Runner

class RunnerTests: XCTestCase {
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
