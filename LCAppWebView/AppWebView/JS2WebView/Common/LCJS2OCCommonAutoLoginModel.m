//
//  LCJS2OCCommonModelLogin.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/4.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCCommonAutoLoginModel.h"

@implementation LCJS2OCCommonAutoLoginModel

+ (void)login:(LCJS2OCCommonAutoLoginModel *)loginModel withSuccessBlock:(void(^)(BOOL success))block;
{
    
    LCHTTPParams *params = [LCHTTPParams paramsWithShortUrlStr:@"User/Account/AutoLogin"];
    params.intercept = NO;
    params.dict = [NSMutableDictionary dictionary];
    params.dict[@"keyString"] = loginModel.keyString;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginModel.keyString forKey:@"loginKeyString"];
    [userDefaults synchronize];
    
    [LCHTTPTool params:params success:^(LCHTTPResult *result) {
        
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
