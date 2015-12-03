//
//  UASocialBoardView.h
//  UAShareSDK
//
//  Created by ccguo on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UASocialSDK.h"

typedef void(^TapBlock) (NSInteger index);

@interface UASocialBoardView : UIView

@property (nonatomic,copy)TapBlock tapBlock;

@end
