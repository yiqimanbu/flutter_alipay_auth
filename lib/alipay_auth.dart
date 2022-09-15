import 'dart:async';

import 'package:flutter/services.dart';

class AlipayAuthPlugin {
  static const MethodChannel _channel = MethodChannel('alipay_auth');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map> aliPayAuth(String auth) async {
    return await _channel.invokeMethod("auth", auth);
  }

  static Future<bool> isAliPayInstalled() async {
    return await _channel.invokeMethod("isAliPayInstalled");
  }
}
