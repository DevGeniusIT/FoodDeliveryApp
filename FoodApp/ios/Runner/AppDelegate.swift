import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseMessaging
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDem6tbEobOfBYhLkN3r6bb_gpMJQ-XAVQ") //AIzaSyDJRQI2x4n8XsdgTXaQ3BSe5zVcZvNiUmA
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  /* override func application(_ application: UIApplication,
  didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){

  Messaging.messaging().apnsToken = deviceToken
    print("Token: \(deviceToken)")
    super.application(application),
    didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
  } */
}
