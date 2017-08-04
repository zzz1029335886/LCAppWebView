//
//  LCJS2OC.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/4.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCModel.h"
#import "LCJS2OCCommonLoginModel.h"
#import "LCJS2OCCommonLogoutModel.h"
#import "LCJS2OCCommonAutoLoginModel.h"
#import "LCJS2OCCommonUploadImageModel.h"


// 枚举上传图片类型
typedef enum : NSUInteger {
    LCJS2OCCommonModelActionTypeNone = 0,//无
    LCJS2OCCommonModelActionTypeLogin,//登录
    LCJS2OCCommonModelActionTypeLogout,//退出
    LCJS2OCCommonModelActionTypeAutoLogin,//自动登录
    LCJS2OCCommonModelActionTypeUploadImage,//图片上传
    
} LCJS2OCCommonModelActionType;

@interface LCJS2OCCommonModel : LCJS2OCModel





@end
