//
//  UASocialManager.h
//  UAShareSDK
//
//  Created by ccguo on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "UASocialConfig.h"
#import "WeiboSDK.h"
#import "WXApi.h"

typedef NS_ENUM(NSInteger,UASocialChannelType)
{
    UASocialChannelWeiXin = 1,
    UASocialChannelWeiXinTimeLine,
    UASocialChannelWeiBo,
    UASocialChannelQQ,
    UASocialChannelQzone,
    UASocialChannelCopy
};

typedef NS_ENUM(NSInteger,UASocialResaultType)
{
    UASocialResaultSucces = 0,
    UASocialResaultCancel,
    UASocialResaultFail
};

@interface UASocialManager : NSObject

+ (void)registWithAppID:(NSString *)appID debugModel:(BOOL)debug socialType:(UASocialChannelType)type;

- (void)sendWBRequest:(WBMessageObject *)message;

- (BOOL)sendWXRequest:(BaseReq *)message;

- (void)sendtoQQRequest:(QQApiNewsObject*)message;

- (void)sendQQzoneRequest:(QQApiNewsObject*)message;

- (BOOL)handleOpenURL:(NSURL *)url;

@end
