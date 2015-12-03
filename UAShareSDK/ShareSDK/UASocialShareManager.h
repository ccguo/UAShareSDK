//
//  UAShareSDKManager.h
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UASocialManager.h"

@interface UASocialShareManager : NSObject

+ (instancetype)shareInstance;

+ (NSArray *)getShareListWithType:(UASocialChannelType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

- (void)shareToInfo;
@end
