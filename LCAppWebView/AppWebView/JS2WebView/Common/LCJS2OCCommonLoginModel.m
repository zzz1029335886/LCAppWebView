//
//  LCJS2OCCommonLoginModel.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/5.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCCommonLoginModel.h"

@implementation LCJS2OCCommonLoginModel
+ (void)login:(LCJS2OCCommonLoginModel *)loginModel withSuccessBlock:(void(^)(BOOL success))block;
{
    
    LCHTTPParams *params = [LCHTTPParams paramsWithShortUrlStr:@"User/Account/Login"];
    params.intercept = NO;
    
    params.dict[@"type"] = loginModel.type;
    params.dict[@"userName"] = loginModel.userName;
    params.dict[@"password"] = loginModel.password;
    
    [LCHTTPTool params:params resultClass:[LCUserInfoResult class] success:^(LCHTTPResult *result) {
        
        if(result.code == 1){
//            [LCHTTPTool setIsLogin:YES];
            
        }else{
//            [LCHTTPTool setIsLogin:NO];
            
        }
        
        if(block){
            block(result.code == 1);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
@end
