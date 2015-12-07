//
//  UAShareSDKManager.h
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UASocialSDKSingle.h"
#import "UASocialManager.h"

@class UASocialShareModel;
@interface UASocialShareManager : NSObject

@property (nonatomic,assign) BOOL debugModel;

+ (instancetype)shareInstance;

/**
 *  注册app ID
 *
 *  @param appID      app ID
 *  @param debugModel model
 *  @param type       渠道类型
 */
- (void)registWithAppID:(NSString *)appID debugModel:(BOOL)debugModel socialType:(UASocialChannelType)type;

/**
 *  分享调用入口
 *
 *  @param model 分享model
 *  @param list  渠道列表,可以为nil,传入nil默认显示所有的渠道
 *  @param block 回调block
 */
- (void)shareWithModel:(UASocialShareModel *)model shareList:(NSArray *)list completion:(void(^)(NSDictionary *shareInfo,BOOL result))block;

@end


/**
 *  分享数据model
 */

@interface UASocialShareModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *pageUrl;
@property (nonatomic,strong) NSString *imageUrl;
@end
