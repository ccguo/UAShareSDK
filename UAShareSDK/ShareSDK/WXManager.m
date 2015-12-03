//
//  WXManager.m
//  JD4iPhone
//
//  Created by Jason on 14-5-12.
//  Copyright (c) 2014年 360buy. All rights reserved.
//

#import "WXManager.h"
#import "WXApi.h"

@interface WXManager () <WXApiDelegate>

/**
 *  发送消息到微信完成
 *
 *  @param resp 具体的回应内容
 */
- (void)sendMessageFinished:(BaseResp *)resp;

/**
 *  微信支付完成
 *
 *  @param resp 具体的回应内容
 */
- (void)payFinished:(BaseResp *)resp;

@end

@implementation WXManager

SYNTHESIZE_SINGLETON_FOR_CLASS(WXManager);

#pragma mark - Public Methods

+ (void)initializeWX
{
    // 注册微信
    [WXApi registerApp:WECHAT_APP_KEY];
}

+ (BOOL)isInstalled
{
    return [WXApi isWXAppInstalled];
}

+ (BOOL)isSupportApi
{
    return [WXApi isWXAppSupportApi];
}

+ (BOOL)sendReq:(BaseReq *)req
{
    return [WXApi sendReq:req];
}

+ (void)requestPay:(NSDictionary *)payInfo
{
    if (JDUtils.validateDictionary(payInfo) == NO)
    {
        return;
    }
    
    //调起微信支付
    NSString *openID    = WECHAT_APP_KEY;
    NSString *partnerID = [payInfo objectForKey:@"partnerId"];
    NSString *prepayID  = [payInfo objectForKey:@"prepayId"];
    NSString *nonceStr  = [payInfo objectForKey:@"nonceStr"];
    UInt32 timeStamp    = [[payInfo objectForKey:@"timeStamp"] doubleValue];
    NSString *package   = [payInfo objectForKey:@"package"];
    NSString *sign      = [payInfo objectForKey:@"sign"];
    
    PayReq* req     = [[[PayReq alloc] init]autorelease];
    req.openID      = openID;
    req.partnerId   = partnerID;
    req.prepayId    = prepayID;
    req.nonceStr    = nonceStr;
    req.timeStamp   = timeStamp;
    req.package     = package;
    req.sign        = sign;
    
    [WXApi sendReq:req];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - Private Methods

- (void)sendMessageFinished:(BaseResp *)resp
{
    switch (resp.errCode)
    {
        case WXSuccess:
        {
            NSDictionary *info = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"分享成功",
                                                                      WECHAT_SHARE_CLIENT,
                                                                      [NSNumber numberWithInt:share_resault_type_success],nil]
                                                             forKeys:[NSArray arrayWithObjects:@"msg", @"client", SHARE_RESAULT_TYPE,nil]];
            [[NSNotificationCenter defaultCenter] postNotificationName:DID_SEND_SUCCESS_OR_FAIL
                                                                object:[NSNumber numberWithBool:YES]
                                                              userInfo:info];
        }
            break;
            
        case WXErrCodeUserCancel:
        {
            NSDictionary *info = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"分享取消",
                                                                      WECHAT_SHARE_CLIENT,
                                                                      [NSNumber numberWithInt:share_resault_type_cancel],nil]
                                                             forKeys:[NSArray arrayWithObjects:@"msg", @"client",SHARE_RESAULT_TYPE, nil]];
            [[NSNotificationCenter defaultCenter] postNotificationName:DID_SEND_SUCCESS_OR_FAIL
                                                                object:[NSNumber numberWithBool:NO]
                                                              userInfo:info];
        }
            break;
            
        default:
        {
            NSDictionary *info = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"分享失败",
                                                                      WECHAT_SHARE_CLIENT,
                                                                      [NSNumber numberWithInt:share_resault_type_fail],nil]
                                                             forKeys:[NSArray arrayWithObjects:@"msg", @"client", SHARE_RESAULT_TYPE,nil]];
            [[NSNotificationCenter defaultCenter] postNotificationName:DID_SEND_SUCCESS_OR_FAIL
                                                                object:[NSNumber numberWithBool:NO]
                                                              userInfo:info];
        }
            break;
    }
}

- (void)payFinished:(BaseResp *)resp
{
    NSString *strMsg = nil;
    switch (resp.errCode)
    {
        case WXSuccess:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:JD_MSG_WX_PAY_SUCCESS
                                                                object:nil];
        }
            break;
            
        case WXErrCodeUserCancel:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:JD_MSG_WX_PAY_CANCEL
                                                                object:nil];
        }
            break;
            
        default:
        {
            strMsg = @"抱歉，支付失败。";
            [[NSNotificationCenter defaultCenter] postNotificationName:JD_MSG_WX_PAY_FAILD
                                                                object:nil];
        }
            break;
    }
    
    // 弹出提示信息
    if (JDUtils.validateString(strMsg))
    {
        JDUtils.showAlert(strMsg);
    }
}

#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    // 发送消息结果
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        [self sendMessageFinished:resp];
    }
    // 支付结果
    else if ([resp isKindOfClass:[PayResp class]])
    {
        [self payFinished:resp];
    }
    // 微信登录
    else if ([resp isKindOfClass:[SendAuthResp class]])
    {
        NSString *code = [(SendAuthResp *)resp code];
        if (JDUtils.validateString(code)) {
            [[NSNotificationCenter defaultCenter] postNotificationName:WX_LOGIN_RESP
                                                                object:resp
                                                              userInfo: [NSDictionary dictionaryWithObject:code forKey:@"code"]];
        }
    }

}

@end