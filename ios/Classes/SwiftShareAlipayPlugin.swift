import Flutter
import UIKit
//import "APOpenAPI.h"

public class SwiftShareAlipayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "share_alipay", binaryMessenger: registrar.messenger())
    let instance = SwiftShareAlipayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
      switch call.method {
        case fluapMethodsRegister:
          registerAP(call,result:result)
      case fluapMethodsIsAppInstalled:
          isAppInstalled(result:result)
      case fluapMethodsShareText:
          shareText(call, result: result)
      case fluapMethodsShareImageUrl:
          shareImageUrl(call,result:result)
      case fluapMethodsShareImageData:
        shareImageData(call,result:result)
      case fluapMethodsShareWebImageUrl:
        shareWebPage(call,result:result)
      case fluapMethodsShareWebImageData:
          shareWebPage(call,result:result)
      default:
          print("======支付宝插件======default")
      }
      
  }
    
    
    
    
    
    func registerAP(_ call: FlutterMethodCall, result:FlutterResult) {
        
        let arguments = call.arguments as![String:String]
        let appId = arguments["appId"]! as String
      print("支付宝分享插件===注册支付宝分享\(appId)")
        
    }
    func isAppInstalled(result:FlutterResult) {
        print("支付宝分享插件===isAppInstalled")

    }
    
    
    func shareText(_ call: FlutterMethodCall, result: FlutterResult) {
        print("支付宝分享插件===shareText")

    }
    
    
    func shareImageData(_ call: FlutterMethodCall, result: FlutterResult) {
        print("支付宝分享插件===shareImageData")

    }
    
    
    func shareImageUrl(_ call: FlutterMethodCall, result: FlutterResult) {
      print("支付宝分享插件===shareImageUrl")
    
    }
    
    
    func shareWebPage(_ call: FlutterMethodCall, result: FlutterResult) {
        print("支付宝分享插件===shareWebPage")

    }
}


