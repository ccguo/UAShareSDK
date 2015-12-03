//
//  UAShareSDKSingle.h
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#ifndef UAShareSDKSingle_h
#define UAShareSDKSingle_h

#define SYNTHESIZE_SINGLE_CLASS(classname)\
static classname *shareInatance = nil;\
\
+ (instancetype)shareInstance{\
@synchronized(self){\
if (shareInatance == nil) {\
shareInatance = [[classname alloc] init];\
}\
}\
return shareInatance;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
@synchronized(self){\
if (shareInatance == nil) {\
shareInatance = [super allocWithZone:zone];\
}\
}\
return shareInatance;\
}\
\
- (instancetype)copy{\
return shareInatance;\
}\


#endif /* UAShareSDKSingle_h */
