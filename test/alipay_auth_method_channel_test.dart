import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alipay_auth/alipay_auth_method_channel.dart';

void main() {
  MethodChannelAlipayAuth platform = MethodChannelAlipayAuth();
  const MethodChannel channel = MethodChannel('alipay_auth');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
