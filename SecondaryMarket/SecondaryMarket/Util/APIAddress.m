//
//  APIAddress.m
//  SecondHandTradingMarket
//
//  Created by wuxinyi on 15-4-23.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "APIAddress.h"

@implementation APIAddress
/**
 *  发送短信验证码
 *
 *  @return <#return value description#>
 */
+(NSString*) ApiSendSMSCaptcha
{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/sendSMSCaptcha.action"];
}

/**
 *  核准输入的短信验证码
 *
 *  @return <#return value description#>
 */
+(NSString*) ApiCheckCaptcha
{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/checkCaptcha.action"];
}

/**
 *  核准用户登录
 *
 *  @return <#return value description#>
 */
+(NSString*) ApiCheckLogin
{
    DLog(@"PubServer_URL = %@",[ConfigManager sharedInstance].PubServer_URL);
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/checkLogin.action"];
}

/**
 *  获取用户信息
 *
 *  @return <#return value description#>
 */
+(NSString*) ApiGetUser
{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/getUser.action"];
}

/**
 *  用户登录名唯一验证 *
 *  @return <#return value description#>
 */
+(NSString*) ApiExistUser
{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/existUser.action"];
}

/**
 *  根据用户主键查用户
 *  @return <#return value description#>
 */
+(NSString*) ApiGetUserById
{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/getUserById.action"];
}

/**
 *  通过旧密码重置密码
 *  @return <#return value description#>
 */
+(NSString*) ApiUpdatePwdByOld;

{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/updatePwdByOld.action"];
}

/**
 *  通过短信验证码重置密码
 *  @return <#return value description#>
 */
+(NSString*) ApiUpdatePwdByCaptcha
{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/updatePwdByCaptcha.action"];
}

/**
 *  核准注册
 *  @return <#return value description#>
 */
+(NSString*) ApiVerifyRegister
{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/verifyRegister.action"];
}

/**
 *  新建用户
 *  @return <#return value description#>
 */
+(NSString*) ApiCreateUser;

{
    return [[ConfigManager sharedInstance].PubServer_URL stringByAppendingString:@"/createUser.action"];
}
@end
