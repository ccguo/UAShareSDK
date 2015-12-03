//
//  QQLoginManager.m
//  JD4iPhone
//
//  Created by wheelswang on 6/17/14.
//  Copyright (c) 2014 360buy. All rights reserved.
//

#import "QQLoginManager.h"
#import "LoginWebViewController.h"

static QQLoginManager *qqLoginManager;

@interface QQLoginManager ()
{
    JDStoreNetwork  *_network;
    UINavigationController *_nav;
}
@end

@implementation QQLoginManager

-(instancetype) init
{
    return [super initWithAppId:JD_QQ_APPID andDelegate:self];
    
}

+(instancetype) instanceWithNav:nav
{
    if (!qqLoginManager) {
        qqLoginManager = [[QQLoginManager alloc] init];
    }
    qqLoginManager->_nav = nav;
    return qqLoginManager;
}

#pragma mark - QQ 分享

-(void)sendtoQQzone:(QQApiNewsObject*)shareObj
{
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:shareObj];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
}

-(void)sendtoQQ:(QQApiNewsObject*)shareObj
{
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:shareObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];

}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            [[WaitDialog sharedWaitDialog] showFailDialogWithMsg:@"App未注册"];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            [[WaitDialog sharedWaitDialog] showFailDialogWithMsg:@"发送参数错误"];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            [[WaitDialog sharedWaitDialog] showFailDialogWithMsg:@"抱歉，您尚未安装QQ"];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            [[WaitDialog sharedWaitDialog] showFailDialogWithMsg:@"抱歉，您的QQ版本过低"];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [[WaitDialog sharedWaitDialog] showFailDialogWithMsg:@"发送失败"];
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark - TencentSessionDelegate

- (void)tencentDidLogin
{
    [JDMTA_Interface jdmta_event_click:@"QQLoginManager"
                               EventID:@"Qqlogin_Success"
                             EventName:@"tencentDidLogin"
                            ParamValue:nil
                          NextPageName:nil];
    
    ZNLog(@"tencentDidLogin:accessToken:%@ openId:%@ expireIn:%@", [self accessToken], [self openId], self->_expirationDate);
    
    [[UserManager sharedUserManager] loginSdkWithQQOpenId:[self openId] accessToken:[self accessToken]];

}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [JDMTA_Interface jdmta_event_click:@"QQLoginManager"
                               EventID:@"Qqlogin_Cancel"
                             EventName:@"tencentDidNotLogin"
                            ParamValue:nil
                          NextPageName:nil];
    
    NSLog(@"tencentDidNotLogin");
}

- (void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
}

@end
