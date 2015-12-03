//
//  SinaManager.m
//  JD4iPhone
//
//  Created by summer on 15/2/4.
//  Copyright (c) 2015年 360buy. All rights reserved.
//

#import "SinaManager.h"
#import "WeiboSDK.h"

@interface SinaManager() <WeiboSDKDelegate>

@property (nonatomic,copy) NSString *wbtoken;
@property (nonatomic,copy) NSString *wbCurrentUserID;

@end

@implementation SinaManager

//SYNTHESIZE_SINGLETON_FOR_CLASS(SinaManager)

+ (void)initializeWithAppKey:(NSString *)appkey debugMode:(BOOL)mode{
    [WeiboSDK enableDebugMode:mode];
    [WeiboSDK registerApp:appkey];
}

+ (BOOL)isInstalled{
    return [WeiboSDK isWeiboAppInstalled];
}

+ (BOOL)isSupportApi{
    return [WeiboSDK isCanShareInWeiboAPP];
}

- (BOOL)handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)sendRequest:(WBMessageObject *)message{
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = redirect_URI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:self.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

#pragma argument mark - Private Method

- (void)sendMessageFinished:(WBBaseResponse *)response
{
    switch (response.statusCode)
    {
        case WeiboSDKResponseStatusCodeSuccess:
        {
            NSDictionary *info = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"分享成功",
                                                                      SINA_SHARE_CLIENT,
                                                                      [NSNumber numberWithInt:share_resault_type_success],nil]
                                                             forKeys:[NSArray arrayWithObjects:@"msg", @"client",SHARE_RESAULT_TYPE, nil]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:DID_SEND_SUCCESS_OR_FAIL
                                                                object:[NSNumber numberWithBool:YES]
                                                              userInfo:info];
        }
            break;
            
        case WeiboSDKResponseStatusCodeUserCancel:
        {
            NSDictionary *info = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"分享取消",
                                                                      SINA_SHARE_CLIENT,
                                                                      [NSNumber numberWithInt:share_resault_type_cancel], nil]
                                                             forKeys:[NSArray arrayWithObjects:@"msg", @"client",SHARE_RESAULT_TYPE, nil]];
            [[NSNotificationCenter defaultCenter] postNotificationName:DID_SEND_SUCCESS_OR_FAIL
                                                                object:[NSNumber numberWithBool:NO]
                                                              userInfo:info];
        }
            break;
            
        default:
        {
            NSDictionary *info = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"分享失败",
                                                                      SINA_SHARE_CLIENT,
                                                                      [NSNumber numberWithInt:share_resault_type_fail],nil]
                                                             forKeys:[NSArray arrayWithObjects:@"msg", @"client", SHARE_RESAULT_TYPE,nil]];
            [[NSNotificationCenter defaultCenter] postNotificationName:DID_SEND_SUCCESS_OR_FAIL
                                                                object:[NSNumber numberWithBool:NO]
                                                              userInfo:info];
        }
            break;
    }
}

#pragma argument mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    NSLog(@"recevive ... ");
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [self sendMessageFinished:response];
        ZNLog(@"WBBase 微博sdk发送消息");
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        ZNLog(@"WBAuthorize认证结果 ");
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        ZNLog(@"WBPayment支付结果 ");
    }
}

@end
