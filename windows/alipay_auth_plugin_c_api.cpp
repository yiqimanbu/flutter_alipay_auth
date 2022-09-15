#include "include/alipay_auth/alipay_auth_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "alipay_auth_plugin.h"

void AlipayAuthPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  alipay_auth::AlipayAuthPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
