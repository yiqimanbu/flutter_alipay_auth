//
//  AFAuthServiceResponse.h
//  AFServiceSDK
//
//  Created by jiajunchen on 08/01/2018.
//  Copyright © 2018 antfin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 钱包服务调用结果状态吗

 - AFAuthResSuccess: 默认值，业务调用成功，结果数据参见result字段
 - AFAuthResInvalidService: service枚举值错误
 - AFAuthResInvalidURL: 钱包回跳URL错误
 - AFAuthResRepeatCall: 业务重复调用（3s内）
 - AFAuthResOpenURLErr: 跳转失败
 */
typedef NS_ENUM(NSUInteger, AFAuthResCode) {
    AFAuthResSuccess = 0,
    AFAuthResInvalidService = 100,
    AFAuthResInvalidURL,
    AFAuthResRepeatCall,
    AFAuthResOpenURLErr,
};


@interface AFAuthServiceResponse : NSObject


/**
 业务调用状态吗
 */
@property (nonatomic, assign) AFAuthResCode responseCode;


/**
 业务结果Dictionary, 内容请参考具体业务方接入文档
 */
@property (readonly) NSDictionary *result;

@end
