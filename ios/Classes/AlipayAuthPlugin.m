#import "AlipayAuthPlugin.h"
#if __has_include(<alipay_auth/alipay_auth-Swift.h>)
#import <alipay_auth/alipay_auth-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "alipay_auth-Swift.h"
#endif

@implementation AlipayAuthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAlipayAuthPlugin registerWithRegistrar:registrar];
}
@end
