//
//  UASocialSDKDefine.h
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/4.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#ifndef UASocialSDKDefine_h
#define UASocialSDKDefine_h

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

static NSString *const UASocialShareResultNotificationName = @"UASocialShareResultNotificationName";

#endif /* UASocialSDKDefine_h */
