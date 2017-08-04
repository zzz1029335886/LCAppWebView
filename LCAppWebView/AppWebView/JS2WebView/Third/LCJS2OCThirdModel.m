//
//  LCJS2OCThirdModel.m
//  kryb
//
//  Created by 凌创科技 on 2017/7/18.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCThirdModel.h"

@implementation LCJS2OCThirdModel
- (void)setAction:(NSString *)action
{
    [super setAction:action];
    
    if ([action isEqualToString:@"Login"]) {
        self.actionType = LCJS2OCThirdModelActionTypeLogin;
    }else if ([action isEqualToString:@"Share"]) {
        self.actionType = LCJS2OCThirdModelActionTypeShare;
    }else if ([action isEqualToString:@"Pay"]) {
        self.actionType = LCJS2OCThirdModelActionTypePay;
    }
}

- (void)setThirdName:(NSString *)thirdName
{
    _thirdName = thirdName;
    
    if ([thirdName isEqualToString:@"Wechat"]) {
        self.thirdType = LCJS2OCThirdModelTypeWechat;
    }else if ([thirdName isEqualToString:@"QQ"]) {
        self.thirdType = LCJS2OCThirdModelTypeQQ;
    }else if ([thirdName isEqualToString:@"Ali"]) {
        self.thirdType = LCJS2OCThirdModelTypeAli;
    }else{
        self.thirdType = LCJS2OCThirdModelTypeNone;
    }
    
}
@end
