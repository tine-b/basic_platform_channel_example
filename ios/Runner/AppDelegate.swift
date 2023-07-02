import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "sampleChannel", binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      var status = ""
       let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true  
      
      if (call.method == "isCharging") { 
        switch device.batteryState {
          case UIDevice.BatteryState.charging:
            status = "Charging"
          case UIDevice.BatteryState.unplugged:
            status = "Not charging"
          case UIDevice.BatteryState.full:
            status = "Fully-charged"
          case UIDevice.BatteryState.unknown:
            fallthrough
          default:
            status = "Unknown"
        }
        result(status)   
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
