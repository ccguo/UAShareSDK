//
//  UAShareSDKManager.h
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,UAShareSDKChannelType)
{
    UAShareSDKChannelWeiXin = 0,
    UAShareSDKChannelWeiXinTimeLine,
    UAShareSDKChannelWeiBo,
    UAShareSDKChannelQQ,
    UAShareSDKChannelQzone
};

@interface UAShareSDKManager : NSObject

+ (instancetype)shareInstance;

@end
