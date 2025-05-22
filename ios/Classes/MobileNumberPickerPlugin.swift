import Flutter
import UIKit

public class MobileNumberPickerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mobile_number_picker", binaryMessenger: registrar.messenger())
    let instance = MobileNumberPickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getMobileNumbers": result("{\"code\": 404, \"errorMessage\": \"PHONE HINT FAILED\"}")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
