[中文移步这里](https://github.com/yiqimanbu/flutter_alipay_auth/blob/main/README_CN.md)
>contact us QQ:1552755354

# What's alipay_auth
alipay_auth is a flutter plugin for AliPayAuth.

# Getting Started

I highly recommend that you - [read the official documents](https://opendocs.alipay.com/open/218/sxc60m) before using alipay_auth.
alipay_auth helps you to do something but not all. For example, you have to configure your URL Scheme on iOS.

# AliPayAuth
```
await AlipayAuthPlugin.aliPayAuth('your auth str');
```

The result is map contains results from AliPayAuth.The result also contains an external filed named platform 
which means the result is from **iOS** or **android**. Result sample:

```
{
app_id: "",
auth_code:"",
result_code: SUCCESS,
scope: auth_user,
state: init,
platform: android
}
```

# Check AliPay Installation

```
var result = await isAliPayInstalled();
```

If you want to check alipay installation of Alipay on iOS,make sure you have added alipays into your whitelist in info.plist.
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>alipay</string>
    <string>alipays</string>
</array>
```
For iOS,yout have to add url schema named alipay. On Xcode GUI: url_schema
in your info.plist:

```
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>alipay</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>alipay_auth_example</string>
        </array>
    </dict>
</array>
```

