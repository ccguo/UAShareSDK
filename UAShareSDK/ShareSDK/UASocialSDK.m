//
//  UASocialSDK.m
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/4.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UASocialSDK.h"

@interface UASocialSDK (){
    
}

@property (nonatomic,assign) BOOL debugModel;
@end

@implementation UASocialSDK

+ (void)registWithAppID:(NSString *)appID socialType:(UASocialChannelType)type
{
    [[UASocialShareManager shareInstance] registWithAppID:appID debugModel:NO socialType:type];
}

+ (void)shareWithModel:(UASocialShareModel *)model shareList:(NSArray *)list completion:(CompletionBlock)block
{
    [[UASocialShareManager shareInstance] shareWithModel:model
                                               shareList:list
                                              completion:block];
}


+ (NSArray *)getShareListWithType:(UASocialChannelType)firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, firstObj);
    NSMutableArray *itemsArray = [NSMutableArray array];
    
    for (NSInteger idx = firstObj; idx>0; idx = va_arg(args,NSInteger)) {
        [itemsArray addObject:[NSNumber numberWithInteger:idx]];
    }
    
    va_end(args);
    
    return itemsArray;
}


+ (void)setDebugModel:(BOOL)debug
{
    [[UASocialShareManager shareInstance] setDebugModel:debug];
}

+ (BOOL)debugModel
{
    return [[UASocialShareManager shareInstance] debugModel];
}

@end
