import Flutter
import UIKit
import AFServiceSDK

public class SwiftAlipayAuthPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "alipay_auth", binaryMessenger: registrar.messenger())
    let instance = SwiftAlipayAuthPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar .addApplicationDelegate(instance)
  }
  
  var authResult: FlutterResult?

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "isAliPayInstalled":
        isAliPayInstalled(call, result: result);
        break;
      case "auth" :
        auth(call, result: result);
        break
      default :
        break
    }
  }
  
  private func isAliPayInstalled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    var isAliPayInstalled: Bool? = nil
    if let url = URL(string: "alipays://"), let anUrl = URL(string: "alipay://") {
        isAliPayInstalled = UIApplication.shared.canOpenURL(url) || UIApplication.shared.canOpenURL(anUrl)
    }
    result(isAliPayInstalled)
  }
    
  private func auth(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    authResult = result;
    let params = [
      kAFServiceOptionBizParams: ["url": call.arguments as? String],
      kAFServiceOptionCallbackScheme: getUrlScheme() ?? ""
    ] as [String: Any]
    AFServiceCenter.call(AFService.auth, withParams: params) { response in
      if AFAuthResCode.success == response?.responseCode {
         if let result = response?.result {
           self.onAuthResultReceived(result)
         }
       }
    }
  }
  
  public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return handleOpenURL(url)
  }
  
  public func application(_ application: UIApplication, open url: URL, sourceApplication: String, annotation: Any) -> Bool {
    return handleOpenURL(url)
  }
  
  private func handleOpenURL(_ url: URL) -> Bool {
    if url.host == "apmqpdispatch" {
      AFServiceCenter.handleResponseURL(url) { response in
        if AFAuthResCode.success == response?.responseCode {
           if let result = response?.result {
             self.onAuthResultReceived(result)
           }
         }
       }
    }
    return true
  }

  func onAuthResultReceived(_ resultDic: [AnyHashable : Any]) {
    var mutableDictionary = resultDic
    mutableDictionary["platform"] = "ios"
    authResult?(mutableDictionary)
    authResult = nil
  }
  
  func getUrlScheme() -> String? {
      let infoDic = Bundle.main.infoDictionary
      let types = infoDic?["CFBundleURLTypes"] as? [AnyHashable]
      for dic in types ?? [] {
        guard let dic = dic as? [AnyHashable : Any] else {
          continue
        }
        if "alipay" == dic["CFBundleURLName"] as? String {
          return (dic["CFBundleURLSchemes"] as? [Any])?[0] as? String
        }
      }
      return nil
  }
  
}
