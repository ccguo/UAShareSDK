//
//  QQLoginManager.h
//  JD4iPhone
//
//  Created by wheelswang on 6/17/14.
//  Copyright (c) 2014 360buy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>

#define JD_QQ_APPID @"100273020"
#define JD_QQ_URL_SCHEMA @"tencent100273020"

@interface QQLoginManager : TencentOAuth<TencentSessionDelegate>

+(instancetype) instanceWithNav:nav;

-(void)sendtoQQzone:(QQApiNewsObject*)shareObj;

-(void)sendtoQQ:(QQApiNewsObject*)shareObj;

@end
