//
//  LCJS2OCCommonModelLogout.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/4.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCCommonLogoutModel.h"

@implementation LCJS2OCCommonLogoutModel
+ (void)logout:(LCJS2OCCommonLogoutModel *)model withSuccessBlock:(void(^)(BOOL success))block;
{
    
    LCHTTPParams *params = [LCHTTPParams paramsWithShortUrlStr:@"User/Account/Logout"];
    params.intercept = NO;
    [LCHTTPTool params:params success:^(LCHTTPResult *result) {
        if(result.code == 1){
//            [LCHTTPTool setIsLogin:NO];
            
        }else{
//            [LCHTTPTool setIsLogin:YES];
        }
        
        if(block){
            block(result.code == 1);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
@end
