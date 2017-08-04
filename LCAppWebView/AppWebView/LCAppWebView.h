//
//  LCAppWebView.h
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface LCAppWebView : WKWebView
+ (instancetype)webView;

+ (NSString *)getCookieString:(NSURL *)url;

@end
