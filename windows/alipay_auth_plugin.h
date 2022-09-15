#ifndef FLUTTER_PLUGIN_ALIPAY_AUTH_PLUGIN_H_
#define FLUTTER_PLUGIN_ALIPAY_AUTH_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace alipay_auth {

class AlipayAuthPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AlipayAuthPlugin();

  virtual ~AlipayAuthPlugin();

  // Disallow copy and assign.
  AlipayAuthPlugin(const AlipayAuthPlugin&) = delete;
  AlipayAuthPlugin& operator=(const AlipayAuthPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace alipay_auth

#endif  // FLUTTER_PLUGIN_ALIPAY_AUTH_PLUGIN_H_
