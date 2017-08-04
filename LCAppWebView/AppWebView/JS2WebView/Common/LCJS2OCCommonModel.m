//
//  LCJS2OC.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/4.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCCommonModel.h"

@implementation LCJS2OCCommonModel


- (void)setAction:(NSString *)action{
    [super setAction:action];
    
    if ([action isEqualToString:@"AutoLogin"]) {
        self.actionType = LCJS2OCCommonModelActionTypeAutoLogin;
    }else if ([action isEqualToString:@"Logout"]) {
        self.actionType = LCJS2OCCommonModelActionTypeLogout;
    }else if ([action isEqualToString:@"Login"]) {
        self.actionType = LCJS2OCCommonModelActionTypeLogin;
    }else if ([action isEqualToString:@"UploadImage"]) {
        self.actionType = LCJS2OCCommonModelActionTypeUploadImage;
    }
}
@end
