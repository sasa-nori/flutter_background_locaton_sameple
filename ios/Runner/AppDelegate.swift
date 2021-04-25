import UIKit
import Flutter
import BackgroundTasks

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let channel = "com.example.background_sample/background_service"
    
    let methodStartBackgroundService = "startBackgroundService"
    let methodCancelBackgroundService = "cancelBackgroundService"
    
    let identifiler :String = "com.example.background-sample.process"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channel,
                                                  binaryMessenger: controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == self.methodStartBackgroundService {
                guard let args = call.arguments as? [AnyHashable: Any] else {
                    result(false)
                    return
                }
                let methodName = args["methodName"] as! String
                let minutes = args["minutes"] as! Double?
                BGTaskScheduler.shared.register(forTaskWithIdentifier: self.identifiler, using: nil, launchHandler: { task in
                    methodChannel.invokeMethod(methodName, arguments: nil) { result in
                        
                    }
                    task.setTaskCompleted(success: true)
                })
                self.startWorker(identifiler: self.identifiler, minitues: minutes, result: result)
                
            }
          // Note: this method is invoked on the UI thread.
          // Handle battery messages.
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate {

    @available(iOS 13.0, *)
    func startWorker(identifiler :String, minitues :Double?, result: @escaping FlutterResult) {
        let interval :Double = (minitues != nil) ? minitues! : 15.0
        let request = BGProcessingTaskRequest(identifier: identifiler)
        request.earliestBeginDate = Date(timeIntervalSinceNow: interval * 60)
        do {
            try BGTaskScheduler.shared.submit(request)
            result(true)
        } catch {
            print("Could not nm app refresh: \(error)")
            result(false)
        }
    }
}
