//
//  LCJS2OCThirdModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/7/18.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCModel.h"


// 枚举上传图片类型
typedef enum : NSUInteger {
    LCJS2OCThirdModelActionTypeNone = 0,//z
    LCJS2OCThirdModelActionTypeLogin,//登录
    LCJS2OCThirdModelActionTypeShare,//分享
    LCJS2OCThirdModelActionTypePay,//支付
} LCJS2OCThirdModelActionType;

// 枚举上传图片类型
typedef enum : NSUInteger {
    LCJS2OCThirdModelTypeNone = 0,//z
    LCJS2OCThirdModelTypeWechat,//登录
    LCJS2OCThirdModelTypeQQ,//分享
    LCJS2OCThirdModelTypeAli,//支付
} LCJS2OCThirdModelType;

@interface LCJS2OCThirdModel : LCJS2OCModel
@property (nonatomic,assign)LCJS2OCThirdModelType thirdType;
@property (nonatomic,strong)NSString *thirdName;

@end
