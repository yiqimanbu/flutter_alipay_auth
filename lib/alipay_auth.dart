import 'dart:async';

import 'package:flutter/services.dart';

class AlipayAuthPlugin {
  ///Declare MethodChannel
  static const MethodChannel _channel = MethodChannel('alipay_auth');

  ///obtain platformVersion
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///start auth
  static Future<Map> aliPayAuth(String auth) async {
    return await _channel.invokeMethod("auth", auth);
  }

  ///Determine whether to install Alipay APP
  static Future<bool> isAliPayInstalled() async {
    return await _channel.invokeMethod("isAliPayInstalled");
  }
}
