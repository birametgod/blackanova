import UIKit
import Flutter
import GoogleMaps  // Add this import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyCsssm2muVjmMAZ43uuFdKKjqtNDXG7LEI")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
