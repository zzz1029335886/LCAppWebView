//
//  LCJS2OCBaseModel.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/5.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCBaseModel.h"

@implementation LCJS2OCBaseModel

- (void)setAction:(NSString *)action{
    [super setAction:action];
    
    if([action isEqualToString:@"ImageBrowser"]){
        self.actionType = LCJS2OCBaseModelActionTypeImageBrowser;
    }else if ([action isEqualToString:@"VideoPlayer"]){
        self.actionType = LCJS2OCBaseModelActionTypeVideoPlayer;
    }else if ([action isEqualToString:@"Finish"]){
        self.actionType = LCJS2OCBaseModelActionTypeFinish;
    }else if ([action isEqualToString:@"SetNav"]){
        self.actionType = LCJS2OCBaseModelActionTypeSetNav;
    }
}



@end
