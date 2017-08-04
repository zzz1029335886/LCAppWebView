//
//  LCJS2OCCommonLoginModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/5.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCJS2OCCommonLoginModel : NSObject
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *password;

+ (void)login:(LCJS2OCCommonLoginModel *)loginModel withSuccessBlock:(void(^)(BOOL success))block;

@end
