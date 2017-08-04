//
//  LCAppWebViewController+JS.h
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewController.h"

@interface LCAppWebViewController (JS)<WKScriptMessageHandler>

- (void)addScriptMessageHandler;
- (void)didReceiveScriptMessage:(WKScriptMessage *)message;

@end
