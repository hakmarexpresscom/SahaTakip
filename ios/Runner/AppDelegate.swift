import UIKit
import Flutter
import GoogleMaps
import Photos  // Eklediğimiz Photos framework'ünü import ettik.

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Google Haritalar API anahtarınızı burada sağladığınızdan emin olun.
    GMSServices.provideAPIKey("AIzaSyCiElU8MOfQ8m9ht76QUiUvuhZyzVtiztA")

    // Fotoğraf izni için kullanılan kısım.
    if #available(iOS 10.0, *) {
      PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
        switch status {
        case .authorized:
          print("Access granted")
        case .denied, .restricted, .notDetermined:
          print("Access denied")
        }
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
