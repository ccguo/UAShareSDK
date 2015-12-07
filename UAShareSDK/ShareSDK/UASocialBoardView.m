//
//  UASocialBoardView.m
//  UAShareSDK
//
//  Created by ccguo on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UASocialBoardView.h"
#import "UIColor+Random.h"

#define TAG 5000

@interface UASocialBoardView ()<UIScrollViewDelegate>

@property (nonatomic,strong)NSArray *itemArray;
@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation UASocialBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH,100)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    _itemArray = @[@(1),@(2),@(3),@(4),@(5)];
    [self processData:_itemArray];
    _scrollView.contentSize = CGSizeMake(_itemArray.count * 90, 100);
}

- (void)processData:(NSArray *)array
{
    CGFloat width = 70;
    CGFloat space = 20;
    __weak typeof (self) weakself = self;

    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    array = array ? array : _itemArray;
    
    [array enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop){
        UASocialChannelType channelType = [obj integerValue];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(idx * (width+space) , 15, width, width);
        button.backgroundColor = [UIColor randomColor];
        button.tag = TAG + idx + 1;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];

        [weakself setItemTitle:button WithChannelType:channelType];
        [_scrollView addSubview:button];
    }];
}

- (void)setItemTitle:(UIButton *)button WithChannelType:(UASocialChannelType)channelType
{
    switch (channelType) {
        case UASocialChannelWeiXin:
            [button setTitle:@"微信" forState:UIControlStateNormal];
            break;
        case UASocialChannelWeiXinTimeLine:
            [button setTitle:@"朋友圈" forState:UIControlStateNormal];
            [_scrollView addSubview:button];
            break;
        case UASocialChannelWeiBo:
            [button setTitle:@"微博" forState:UIControlStateNormal];
            [_scrollView addSubview:button];
            break;
        case UASocialChannelQQ:
            [button setTitle:@"QQ" forState:UIControlStateNormal];
            [_scrollView addSubview:button];
            break;
        case UASocialChannelQzone:
            [button setTitle:@"QQ空间" forState:UIControlStateNormal];
            [_scrollView addSubview:button];
            break;
        case UASocialChannelCopy:
            [button setTitle:@"拷贝" forState:UIControlStateNormal];
            [_scrollView addSubview:button];
            break;
            
        default:
            break;
    }
}

- (void)btnPressed:(UIButton *)sender
{
    NSInteger channelType = sender.tag - TAG;
    if (_tapBlock) {
        _tapBlock(channelType);
    }
}
@end
