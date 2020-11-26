import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    //FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyCCwK2XfDzKgh95cmJy0hF_XDnLISsXkEQ")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
