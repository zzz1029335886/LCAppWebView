//
//  LCWebViewController+OC2JS.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/17.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewController.h"

@interface LCAppWebViewController (OC2JS)

- (void)rightNavBarClick;
- (void)rightNavBarClickWithTitle:(NSString *)title;
- (void)uploadImage:(NSString *)title imgId:(NSString *)imgId;

@end
