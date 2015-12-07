//
//  UASocialBoardView.h
//  UAShareSDK
//
//  Created by ccguo on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UASocialSDK.h"

#define SCREEN_WIDTH          ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT         ([UIScreen mainScreen].bounds.size.height)
#define BOARD_HEIGHT           300

#define marginTopHiden        (SCREEN_HEIGHT + BOARD_HEIGHT)
#define marginTopShow         (SCREEN_HEIGHT - BOARD_HEIGHT)

typedef void(^TapBlock) (NSInteger index);

@interface UASocialBoardView : UIView

@property (nonatomic,copy)TapBlock tapBlock;

- (void)processData:(NSArray *)array;

@end
