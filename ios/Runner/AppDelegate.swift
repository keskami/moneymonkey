import UIKit
import Flutter
import FirebaseCore // Import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate { // Inherit from FlutterAppDelegate
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure() // Initialize Firebase
    GeneratedPluginRegistrant.register(with: self) // Register Flutter plugins
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
