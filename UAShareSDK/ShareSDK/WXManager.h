//
//  WXManager.h
//  JD4iPhone
//
//  Created by Jason on 14-5-12.
//  Copyright (c) 2014年 360buy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  消息：微信支付成功
 */
#define JD_MSG_WX_PAY_SUCCESS           @"JD_Msg_WX_Pay_Success"

/**
 *  消息：微信支付取消
 */
#define JD_MSG_WX_PAY_CANCEL            @"JD_Msg_WX_Pay_Cancel"

/**
 *  消息：微信支付失败
 */
#define JD_MSG_WX_PAY_FAILD             @"JD_Msg_WX_Pay_Faild"

/**
 *  宏定义：未安装微信时提示信息
 */
#define JD_D_WX_UNINSTALLED_INFO        @"抱歉，您尚未安装微信。"

/**
 *  宏定义：微信版本过低时提示信息
 */
#define JD_D_WX_UNSUPPORT_INFO          @"请升级微信到最新版本使用。"

@class BaseReq;

/**
 *  微信管理相关(分享、支付)
 */
@interface WXManager : NSObject

/**
 *  获取微信管理单例
 *
 *  @return 微信管理单例
 */
+ (WXManager *)sharedWXManager;

/**
 *  初始化微信
 */
+ (void)initializeWX;

/**
 *  检查微信是否已被用户安装
 *
 *  @return 微信已安装返回YES，未安装返回NO。
 */
+ (BOOL)isInstalled;

/**
 *  判断当前微信的版本是否支持OpenApi
 *
 *  @return 支持返回YES，不支持返回NO。
 */
+ (BOOL)isSupportApi;

/**
 *  发送请求到微信，等待微信返回onResp
 *
 *  @param req 具体的发送请求
 *
 *  @return 成功返回YES，失败返回NO。
 */
+ (BOOL)sendReq:(BaseReq*)req;

/**
 *  发请微信支付请求
 *
 *  @param payInfo 支付信息参数
 */
+ (void)requestPay:(NSDictionary *)payInfo;

/**
 *  处理微信通过URL启动App时传递的数据
 *
 *  @param url 启动App的URL
 *
 *  @return 成功返回YES，失败返回NO
 */
- (BOOL)handleOpenURL:(NSURL *)url;


@end
