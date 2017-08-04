//
//  LCJS2OCBaseModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/5.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCModel.h"
#import "LCJS2OCBaseImageBrowserModel.h"
#import "LCJS2OCBaseVideoPlayerModel.h"
#import "LCJS2OCBaseFinishModel.h"
#import "LCJS2OCBaseSetNavModel.h"

// 枚举上传图片类型
typedef enum : NSUInteger {
    LCJS2OCBaseModelActionTypeNone = 0,//无
    LCJS2OCBaseModelActionTypeFinish,//结束
    LCJS2OCBaseModelActionTypeSetNav,//跳转
    LCJS2OCBaseModelActionTypeImageBrowser,//图片浏览
    LCJS2OCBaseModelActionTypeVideoPlayer,//视频播放
    
} LCJS2OCBaseModelActionType;

@interface LCJS2OCBaseModel : LCJS2OCModel

@end
