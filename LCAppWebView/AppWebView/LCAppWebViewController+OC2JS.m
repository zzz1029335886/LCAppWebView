//
//  LCWebViewController+OC2JS.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/17.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewController+OC2JS.h"
#import <MJExtension/MJExtension.h>

@implementation LCAppWebViewController (OC2JS)
- (void)rightNavBarClick;
{
    NSString *jsString = [NSString stringWithFormat:@"$lc.app.rightBtnOnClick()"];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable object, NSError * _Nullable error) {
        
    }];
}
- (void)rightNavBarClickWithTitle:(NSString *)title;
{
    NSString *jsString = [self jsStringWithMethodName:@"rightBtnOnClick" paramsString:title];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable object, NSError * _Nullable error) {
        
    }];
}

- (void)uploadImage:(NSString *)title imgId:(NSString *)imgId;
{
    NSString *jsString = [NSString stringWithFormat:@"$lc.app.uploadImage(\"%@\",\"%@\")",title,imgId];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable object, NSError * _Nullable error) {

    }];
}

- (NSString *)jsStringWithMethodName:(NSString *)methodName paramsString:(NSString *)paramsString{
    return [NSString stringWithFormat:@"%@(\"%@\")",methodName,paramsString];
}

- (NSString *)jsStringWithMethodName:(NSString *)methodName paramsDict:(NSDictionary *)dict{
    return [NSString stringWithFormat:@"%@(%@)",methodName,dict.mj_JSONString];
}

@end
