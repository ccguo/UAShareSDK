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
@property  (nonatomic,assign) BOOL showEnable;
@property  (nonatomic,copy)   CompletionBlock completion;
@property  (nonatomic,copy)   UASocialShareModel *model;
@end

@implementation UASocialShareManager

SYNTHESIZE_SINGLE_CLASS(UASocialShareManager)

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initUI];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveSocialResultInfo:)
                                                     name:UASocialShareResultNotificationName
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUI
{
    __weak typeof (self) weakself = self;

    _boardView = [[UASocialBoardView alloc] initWithFrame:CGRectMake(0,marginTopHiden, SCREEN_WIDTH, BOARD_HEIGHT)];
    _boardView.backgroundColor = [UIColor grayColor];
    [_boardView setTapBlock:^(NSInteger index){
        [weakself didBoardViewItemClickedAtChannelType:index];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:_boardView];
}

- (void)showBoardView
{
    _showEnable = YES;
    [UIView animateWithDuration:1 animations:^{
        _boardView.frame = CGRectMake(0, marginTopShow, SCREEN_WIDTH , BOARD_HEIGHT);
    }];
}

- (void)hideBoardView
{
    _showEnable = NO;
    [UIView animateWithDuration:1 animations:^{
        _boardView.frame = CGRectMake(0, marginTopHiden, SCREEN_WIDTH, BOARD_HEIGHT);
    }];
}

#pragma mark - public method
- (void)registWithAppID:(NSString *)appID debugModel:(BOOL)debugModel socialType:(UASocialChannelType)type
{
    [UASocialManager registWithAppID:appID debugModel:debugModel socialType:type];
}

- (void)shareWithModel:(UASocialShareModel *)model shareList:(NSArray *)list completion:(void(^)(NSDictionary *shareInfo,BOOL result))block;
{
    self.model = model;
    self.completion = block;
    
    [_boardView processData:list];
    
    if (!self.showEnable){
        [self showBoardView];
    }
    else{
        [self hideBoardView];
    }
}

- (void)didBoardViewItemClickedAtChannelType:(NSInteger)channelType
{
    switch (channelType) {
        case UASocialChannelWeiXin:
            
            break;
        case UASocialChannelWeiXinTimeLine:
            
            break;
        case UASocialChannelWeiBo:
            
            break;
        case UASocialChannelQQ:
            
            break;
        case UASocialChannelQzone:
            
            break;
        case UASocialChannelCopy:
            
            break;
        default:
            break;
    }
}

- (void)sendWBRequest:(WBMessageObject *)message
{
    [[UASocialManager shareInstance] sendWBRequest:message];
}

- (BOOL)sendWXRequest:(BaseReq *)message
{
    return [[UASocialManager shareInstance] sendWXRequest:message];
}

- (void)sendToQQRequest:(QQApiNewsObject*)message;
{
    return [[UASocialManager shareInstance] sendToQQRequest:message];
}

- (void)sendQQzoneRequest:(QQApiNewsObject*)message
{
    return [[UASocialManager shareInstance] sendQQzoneRequest:message];
}

#pragma mark - Observer Event
- (void)didReceiveSocialResultInfo:(NSNotification *)noti
{
    
}
@end


@implementation UASocialShareModel

@end
