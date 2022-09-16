import 'dart:async';

import 'package:alipay_auth/alipay_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _alipayAuthPlugin = AlipayAuthPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await AlipayAuthPlugin.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('alipay_auth example'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () async {
              Map map = await AlipayAuthPlugin.aliPayAuth('auth');
              debugPrint('aliPayAuth info:$map');
              String appId = map['app_id'];
              debugPrint('aliPayAuth appId:$appId');
              String authCode = map['auth_code'];
              debugPrint('aliPayAuth authCode:$authCode');
              String scope = map['scope'];
              debugPrint('aliPayAuth scope:$scope');
              String state = map['state'];
              debugPrint('aliPayAuth state:$state');
              String platform = map['platform'];
              debugPrint('aliPayAuth platform:$platform');
            },
            child: const Text(
              '支付宝授权',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
