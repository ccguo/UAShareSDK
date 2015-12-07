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
#import "UASocialSDKDefine.h"
#import "WeiboSDK.h"
#import "WXApi.h"

@interface UASocialManager : NSObject

+ (instancetype)shareInstance;

+ (void)registWithAppID:(NSString *)appID debugModel:(BOOL)debug socialType:(UASocialChannelType)type;

- (void)sendWBRequest:(WBMessageObject *)message;

- (BOOL)sendWXRequest:(BaseReq *)message;

- (void)sendToQQRequest:(QQApiNewsObject*)message;

- (void)sendQQzoneRequest:(QQApiNewsObject*)message;

- (BOOL)handleOpenURL:(NSURL *)url;

@end
