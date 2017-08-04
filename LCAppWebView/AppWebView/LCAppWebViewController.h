//
//  LCAppWebViewController.h
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCAppWebView.h"

#import "LCAppWebViewControllerConfig.h"
#import "LCAppWebViewNavigationConfig.h"

#define LCJS2OCFinishNotification @"LCJS2OCFinishNotification"

@interface LCAppWebViewController : UIViewController

@property (nonatomic,strong)LCAppWebViewControllerConfig *controllerConfig;
@property (nonatomic,strong)LCAppWebViewNavigationConfig *navigationConfig;

@property (nonatomic,strong)LCAppWebView *webView;
@property (nonatomic,strong)UIProgressView *progressView;

@property (nonatomic,strong)NSURL *url;
@property (nonatomic,copy)NSString *urlString;

@property (nonatomic,assign)BOOL refresh;

- (instancetype)initWithUrl:(NSURL *)url;
- (instancetype)initWithUrlString:(NSString *)urlString;

@end
