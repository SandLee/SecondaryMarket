//
//  APIAddress.h
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-23.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIAddress : NSObject

/**
 *  发送短信验证码
 *
 *  @return <#return value description#>
 */
+(NSString*) ApiSendSMSCaptcha;

/**
 *  核准输入的短信验证码
 *
 *  @return <#return value description#>
 */
+(NSString*) ApiCheckCaptcha;

/**
 *  核准用户登录
 *
 *  @return <#return value description#>
 */
+(NSString*) ApiCheckLogin;

/**
 *  获取用户信息
 *
 *  @return <#return value description#>
 */
+(NSString*) ApiGetUser;

/**
 *  用户登录名唯一验证 *
 *  @return <#return value description#>
 */
+(NSString*) ApiExistUser;

/**
 *  根据用户主键查用户
 *  @return <#return value description#>
 */
+(NSString*) ApiGetUserById;

/**
 *  通过旧密码重置密码
 *  @return <#return value description#>
 */
+(NSString*) ApiUpdatePwdByOld;

/**
 *  通过短信验证码重置密码
 *  @return <#return value description#>
 */
+(NSString*) ApiUpdatePwdByCaptcha;

/**
 *  核准注册
 *  @return <#return value description#>
 */
+(NSString*) ApiVerifyRegister;

/**
 *  新建用户
 *  @return <#return value description#>
 */
+(NSString*) ApiCreateUser;
@end
