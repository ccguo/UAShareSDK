//
//  UAShareSDK.h
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UASocialShareManager.h"
#import "UASocialConfig.h"
#import "UASocialSDKDefine.h"

typedef void(^CompletionBlock) (NSDictionary *shareInfo,BOOL result);

@interface UASocialSDK : NSObject

+ (void)registWithAppID:(NSString *)appID socialType:(UASocialChannelType)type;

+ (void)shareWithModel:(UASocialShareModel *)model shareList:(NSArray *)list completion:(CompletionBlock)block;

+ (NSArray *)getShareListWithType:(UASocialChannelType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

+ (void)setDebugModel:(BOOL)debug;

+ (BOOL)debugModel;

@end