//
//  UASocialBoardView.m
//  UAShareSDK
//
//  Created by ccguo on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UASocialBoardView.h"
#import "UIColor+Random.h"

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
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, UA_SCREEN_WIDTH,100)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    _itemArray = @[@(1),@(2),@(3),@(4),@(5)];
    
    CGFloat width = 70;  //
    CGFloat space = 20;
    for (int i = 0; i < _itemArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * (width+space) , 15, width, width);
        button.backgroundColor = [UIColor randomColor];
        [button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    _scrollView.contentSize = CGSizeMake(_itemArray.count * 90, 100);
}

- (void)btnPressed:(UIButton *)sender
{
    if (_tapBlock) {
        _tapBlock(0);
    }
}
@end
