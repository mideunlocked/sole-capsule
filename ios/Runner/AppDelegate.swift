import UIKit
import Flutter
import flutter_plugin_android_lifecycle  // Add this line

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    FirebaseApp.configure()  // Add this line if you're using Firebase

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
