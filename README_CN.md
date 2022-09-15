>联系我们  QQ:1552755354

# alipay_auth 是什么
alipay_auth是一个为支付宝授权SDK做的Flutter插件。

# 开始
在使用前强烈阅读[官方接入指南](https://opendocs.alipay.com/open/218/sxc60m). alipay_auth 可以完成一部分但不是全部工作。 例如，在iOS上你还要设置URL Scheme。

# 支付宝授权
```
await AlipayAuthPlugin.aliPayAuth('your auth str');
```

返回值是一个包含支付宝授权结果的map，其中还包含了一个额外的 platform字段， 它的值为 **iOS** 或 **android**。

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

如果你想在iOS上检测支付宝是否已安装，请确保你已经在info.plist中将alipays添加至白名单。
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>alipay</string>
    <string>alipays</string>
</array>
```

在 iOS中还要添加一个名为alipay的URL Schema，否则无法返回你的app. 通过GUI添加: url_schema
在info.plist文件中添加:

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

