//
//  LCJS2OCCommonModelLogin.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/4.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCJS2OCCommonAutoLoginModel : NSObject
@property (nonatomic,copy)NSString *keyString;


+ (void)login:(LCJS2OCCommonAutoLoginModel *)loginModel withSuccessBlock:(void(^)(BOOL success))block;

@end
