//
//  LCJS2OCQQ.h
//  kryb
//
//  Created by 凌创科技 on 2017/7/18.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCThird.h"

@interface LCJS2OCThirdQQModel : LCJS2OCThird
+ (void)qqWithModel:(LCJS2OCThirdModel *)model withBlock:(void(^)(BOOL success,LCJS2OCThirdModelActionType type,id object))block;

@end
