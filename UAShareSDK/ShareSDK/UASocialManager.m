//
//  UASocialManager.m
//  UAShareSDK
//
//  Created by ccguo on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UASocialManager.h"

@interface UASocialManager ()<WXApiDelegate,WeiboSDKDelegate>
@property (nonatomic,strong) NSString *wbToken;
@property (nonatomic,strong) NSString *wbCurrentUserID;

@end

@implementation UASocialManager

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
    request.userInfo = @{@"ShareMessageFrom": @"UASocialManager"};
    [WeiboSDK sendRequest:request];
}

- (BOOL)sendWXRequest:(BaseReq *)message
{
    return [WXApi sendReq:message];
}

- (void)sendtoQQRequest:(QQApiNewsObject*)message
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
    NSString *urlScheme = [url scheme];
    __weak __typeof__(self) weakSelf = self;
    
    if ([urlScheme isEqualToString:UASOCIAL_WX_KEY]) {
        return [WXApi handleOpenURL:url delegate:weakSelf];
    }
    
    if ([urlScheme isEqualToString:UASOCIAL_WB_KEY]) {
        return [WeiboSDK handleOpenURL:url delegate:weakSelf];
    }
    
    if ([urlScheme isEqualToString:UASOCIAL_QQ_KEY]) {
        return [TencentOAuth HandleOpenURL:url];
    }
    
    return YES;
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case 0:
        {
            //发送成功
            break;
        }
        case -1:
        {
            //发送失败
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark weibo delegate

#pragma argument mark - WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
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
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        //ZNLog(@"WBAuthorize认证结果 ");
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        //ZNLog(@"WBPayment支付结果 ");
    }
}

#pragma argument mark - WXSDK Delegate
#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //处理分享结束
//        [self sendMessageFinished:resp];
    }
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
    
}

@end
