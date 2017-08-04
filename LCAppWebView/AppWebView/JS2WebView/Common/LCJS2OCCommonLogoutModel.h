//
//  LCJS2OCCommonModelLogout.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/4.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCJS2OCCommonLogoutModel : NSObject
+ (void)logout:(LCJS2OCCommonLogoutModel *)model withSuccessBlock:(void(^)(BOOL success))block;;

@end
