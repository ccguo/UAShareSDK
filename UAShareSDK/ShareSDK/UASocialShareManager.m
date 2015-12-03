//
//  UAShareSDKManager.m
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UASocialShareManager.h"
#import "UASocialBoardView.h"
#import "UASocialSDK.h"

@interface UASocialShareManager ()
{
    UASocialBoardView *_boardView;
}

//@property (nonatomic,strong)

@end

@implementation UASocialShareManager
SYNTHESIZE_SINGLE_CLASS(UASocialShareManager)

+ (NSArray *)getShareListWithType:(UASocialChannelType)firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, firstObj);
    for (NSInteger str = firstObj; str>0; str = va_arg(args,NSInteger)) {
         NSLog(@"%ld",str);
    }
    va_end(args);
    
    return @[];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    _boardView = [[UASocialBoardView alloc] initWithFrame:CGRectMake(0, UA_SCREEN_HEIGHT + UA_BOARD_HEIGHT, UA_SCREEN_WIDTH, UA_BOARD_HEIGHT)];
    _boardView.backgroundColor = [UIColor grayColor];
    [_boardView setTapBlock:^(NSInteger index){
        [UIView animateWithDuration:1 animations:^{
            _boardView.frame = CGRectMake(0, UA_SCREEN_HEIGHT + UA_BOARD_HEIGHT, UA_SCREEN_WIDTH, UA_BOARD_HEIGHT);
        }];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:_boardView];
}

- (void)shareToInfo
{
    [UIView animateWithDuration:1 animations:^{
        _boardView.frame = CGRectMake(0, UA_SCREEN_HEIGHT - UA_BOARD_HEIGHT, UA_SCREEN_WIDTH, UA_BOARD_HEIGHT);
    }];
}

@end
