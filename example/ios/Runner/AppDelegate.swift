import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, APOpenAPIDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return APOpenAPI.handleOpen(url, delegate: self)
    }
    
    func onReq(_ req: APBaseReq!) {
        print(req.description)
    }
    
    func onResp(_ resp: APBaseResp!) {
        print(resp.description)
    }
}
