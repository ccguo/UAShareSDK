//
//  UASocialManager.m
//  UAShareSDK
//
//  Created by ccguo on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UASocialManager.h"
#import "UASocialConfig.h"
#import "UASocialSDKSingle.h"

@interface UASocialManager ()<WXApiDelegate,WeiboSDKDelegate>
@property (nonatomic,strong) NSString *wbToken;
@property (nonatomic,strong) NSString *wbCurrentUserID;

@end

@implementation UASocialManager

SYNTHESIZE_SINGLE_CLASS(UASocialManager)

+ (void)registWithAppID:(NSString *)appID debugModel:(BOOL)debug socialType:(UASocialChannelType)type
{
    switch (type) {
        case UASocialChannelWeiXin:
            [WXApi registerApp:appID];
            break;
        case UASocialChannelWeiBo:
            [WeiboSDK enableDebugMode:debug];
            [WeiboSDK registerApp:appID];
            break;
        case UASocialChannelQQ:
            break;
        default:
            break;
    }
}

- (void)sendWBRequest:(WBMessageObject *)message
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = UASOCIAL_WeiBo_Redirect_URL;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:self.wbToken];
    request.userInfo = @{@"UAShareMessage": @"UASocialManager"};
    [WeiboSDK sendRequest:request];
}

- (BOOL)sendWXRequest:(BaseReq *)message
{
    return [WXApi sendReq:message];
}

- (void)sendToQQRequest:(QQApiNewsObject*)message
{
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:message];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

- (void)sendQQzoneRequest:(QQApiNewsObject*)message
{
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:message];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    __weak __typeof__(self) weakSelf = self;
    NSString *urlScheme = [url scheme];
    
    if ([urlScheme isEqualToString:UASOCIAL_WX_KEY])
    {
        return [WXApi handleOpenURL:url delegate:weakSelf];
    }
    
    if ([urlScheme isEqualToString:UASOCIAL_WB_KEY])
    {
        return [WeiboSDK handleOpenURL:url delegate:weakSelf];
    }
    
    if ([urlScheme isEqualToString:UASOCIAL_QQ_KEY])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    
    return YES;
}

#pragma mark - private 方法

- (void)notificationShareResultWithInfo:(NSDictionary *)info
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UASocialShareResultNotificationName object:info];
}

- (NSMutableDictionary *)commongResultInfo
{
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    [dicInfo setObject:[NSNumber numberWithBool:NO] forKey:UA_RESULT_RESULT];
    [dicInfo setObject:@"success" forKey:UA_RESULT_TITLE];
    [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelWeiXin] forKey:UA_RESULT_TYPE];
    return dicInfo;
}

#pragma mark - 回调处理方法
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    NSMutableDictionary *dicInfo = [self commongResultInfo];
    
    switch (sendResult)
    {
        case 0:
        {
            //发送成功
            [dicInfo setObject:[NSNumber numberWithInteger:UASocialResaultSucces] forKey:UA_RESULT_RESULT];
            [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelQQ] forKey:UA_RESULT_TYPE];
            [self notificationShareResultWithInfo:dicInfo];
            break;
        }
        case -1:
        {
            //发送失败
            [dicInfo setObject:[NSNumber numberWithInteger:UASocialResaultFail] forKey:UA_RESULT_RESULT];
            [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelQQ] forKey:UA_RESULT_TYPE];
            [self notificationShareResultWithInfo:dicInfo];
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma argument mark - WeiboSDKDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSMutableDictionary *dicInfo = [self commongResultInfo];

    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbToken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        //处理回调结果  //ZNLog(@"WBBase 微博sdk发送消息");
        
        switch (response.statusCode) {
            case WeiboSDKResponseStatusCodeSuccess:
                [dicInfo setObject:[NSNumber numberWithInteger:UASocialResaultSucces] forKey:UA_RESULT_RESULT];
                [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelWeiBo] forKey:UA_RESULT_TYPE];
                [self notificationShareResultWithInfo:dicInfo];
                break;
            case WeiboSDKResponseStatusCodeUserCancel:
                [dicInfo setObject:[NSNumber numberWithInteger:UASocialResaultCancel] forKey:UA_RESULT_RESULT];
                [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelWeiBo] forKey:UA_RESULT_TYPE];
                [self notificationShareResultWithInfo:dicInfo];
                break;
            default:
                [dicInfo setObject:[NSNumber numberWithInteger:UASocialResaultFail] forKey:UA_RESULT_RESULT];
                [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelWeiBo] forKey:UA_RESULT_TYPE];
                [self notificationShareResultWithInfo:dicInfo];
                break;
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        //UA_DBLog(@"WBAuthorize认证结果 ");
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        //UA_DBLog(@"WBPayment支付结果 ");
    }
}

#pragma argument mark - WXSDK Delegate
#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    NSMutableDictionary *dicInfo = [self commongResultInfo];
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //处理分享结束
        switch (resp.errCode) {
            case WXSuccess:
                [dicInfo setObject:[NSNumber numberWithInteger:UASocialResaultSucces] forKey:UA_RESULT_RESULT];
                [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelWeiXin] forKey:UA_RESULT_TYPE];
                [self notificationShareResultWithInfo:dicInfo];
                break;
            case WXErrCodeUserCancel:
                [dicInfo setObject:[NSNumber numberWithInteger:UASocialResaultCancel] forKey:UA_RESULT_RESULT];
                [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelWeiXin] forKey:UA_RESULT_TYPE];
                [self notificationShareResultWithInfo:dicInfo];
                break;
            default:
                [dicInfo setObject:[NSNumber numberWithInteger:UASocialResaultFail] forKey:UA_RESULT_RESULT];
                [dicInfo setObject:[NSNumber numberWithBool:UASocialChannelWeiXin] forKey:UA_RESULT_TYPE];
                [self notificationShareResultWithInfo:dicInfo];
                break;
        }
    }
    /*
    // 支付结果
    else if ([resp isKindOfClass:[PayResp class]])
    {
        //支付结束回调处理
    }
    // 微信登录
    else if ([resp isKindOfClass:[SendAuthResp class]])
    {
        NSString *code = [(SendAuthResp *)resp code];
        if (code) {
            //处理微信一键登录
        }
    }
     */
}

@end
