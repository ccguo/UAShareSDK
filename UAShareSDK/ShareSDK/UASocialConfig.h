//
//  UASocialConfig.h
//  UAShareSDK
//
//  Created by ccguo on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#ifndef UASocialConfig_h
#define UASocialConfig_h

#define UASOCIAL_WX_KEY     @""
#define UASOCIAL_WB_KEY     @""
#define UASOCIAL_QQ_KEY     @""

#define UASOCIAL_WeiBo_Redirect_URL     @""

#define DBLog(format, ...)  if([UATrackContext shareInstance].logEnable) {NSLog(format,##__VA_ARGS__);}
#define UA_SCREEN_WIDTH          ([UIScreen mainScreen].bounds.size.width)
#define UA_SCREEN_HEIGHT         ([UIScreen mainScreen].bounds.size.height)

#define UA_BOARD_HEIGHT         300


#endif /* UASocialConfig_h */
