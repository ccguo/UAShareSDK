//
//  SinaManager.h
//  JD4iPhone
//
//  Created by summer on 15/2/4.
//  Copyright (c) 2015年 360buy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JD_D_SINA_UNINSTALLED_INFO        @"抱歉，您尚未安装微博。"

@class WBMessageObject;

@interface SinaManager : NSObject

/**
 *  创建单例
 */
+ (SinaManager *)sharedSinaManager;

/**
 *  初始化微博
 */
+ (void)initializeWithAppKey:(NSString *)appkey debugMode:(BOOL)mode;

/**
 *  检查微博是否已被用户安装
 *
 *  @return 微博已安装返回YES，未安装返回NO。
 */
+ (BOOL)isInstalled;

/**
 *  判断当前微博的版本是否支持OpenApi
 *
 *  @return 支持返回YES，不支持返回NO。
 */
+ (BOOL)isSupportApi;


- (void)sendRequest:(WBMessageObject *)message;

/**
 *  处理微博通过URL启动App时传递的数据
 *
 *  @param url 启动App的URL
 *
 *  @return 成功返回YES，失败返回NO
 */
- (BOOL)handleOpenURL:(NSURL *)url;

@end
