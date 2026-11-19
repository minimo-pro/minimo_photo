import Flutter
import UIKit
import BackgroundTasks

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}

@available(iOS 26.0, *)
final class BackgroundPhotoTask {
  static let importRuntime = BackgroundPhotoTask(operation: "import")
  static let compressionRuntime = BackgroundPhotoTask(operation: "compression")
  private let operation: String

  init(operation: String) { self.operation = operation }
  private var task: BGContinuedProcessingTask?
  private var identifier: String?
  private var admission: ((Bool) -> Void)?
  var onCancel: (() -> Void)?

  func makeRequest(token: String) -> BGContinuedProcessingTaskRequest {
    let request = BGContinuedProcessingTaskRequest(
      identifier: Bundle.main.bundleIdentifier! + "." + operation + "." + token,
      title: "minimo", subtitle: "0%"
    )
    request.strategy = .fail
    return request
  }

  func start(token: String, completion: @escaping (Bool) -> Void) {
    finish(success: false)
    guard UIApplication.shared.applicationState == .active else { completion(false); return }
    let request = makeRequest(token: token)
    identifier = request.identifier
    admission = completion
    let registered = BGTaskScheduler.shared.register(
      forTaskWithIdentifier: request.identifier, using: .main
    ) { [weak self] launched in
      guard let self, let task = launched as? BGContinuedProcessingTask,
            self.identifier == request.identifier else {
        launched.setTaskCompleted(success: false)
        return
      }
      self.task = task
      task.progress.totalUnitCount = 1000
      task.expirationHandler = { [weak self] in
        DispatchQueue.main.async {
          guard let self, self.task === task else { return }
          self.onCancel?()
          self.finish(success: false)
        }
      }
      let admitted = self.admission
      self.admission = nil
      admitted?(true)
    }
    guard registered else { finish(success: false); return }
    do {
      try BGTaskScheduler.shared.submit(request)
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
        guard let self, self.identifier == request.identifier, self.admission != nil else { return }
        self.finish(success: false)
      }
    } catch {
      finish(success: false)
    }
  }

  func update(progress: Double, index: Int, count: Int) {
    guard let task, progress.isFinite else { return }
    task.progress.completedUnitCount = Int64(min(999, max(0, progress * 1000)))
    task.updateTitle(task.title, subtitle: "\(index) / \(count) · \(Int(progress * 100))%")
  }

  func finish(success: Bool) {
    if let identifier { BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: identifier) }
    identifier = nil
    let pending = admission
    admission = nil
    if let task {
      task.expirationHandler = nil
      if success { task.progress.completedUnitCount = task.progress.totalUnitCount }
      task.setTaskCompleted(success: success)
    }
    task = nil
    pending?(false)
  }
}
