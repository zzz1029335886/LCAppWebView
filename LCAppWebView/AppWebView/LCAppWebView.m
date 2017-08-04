//
//  LCAppWebView.m
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebView.h"

@interface LCAppWebView ()

@end

@implementation LCAppWebView

static WKProcessPool *_processPool = nil;
+ (WKProcessPool *)processPool
{
    if (!_processPool) {
        _processPool = [[WKProcessPool alloc]init];
    }
    return _processPool;
}

+ (instancetype)webView;
{
    WKUserContentController* userContentController = [[WKUserContentController alloc]init];
    
    NSMutableString *cookies = [NSMutableString string];
    
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:[cookies copy] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:cookieScript];
    
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    // 一下两个属性是允许H5视屏自动播放,并且全屏,可忽略
    configuration.allowsInlineMediaPlayback = YES;
    configuration.mediaPlaybackRequiresUserAction = NO;
    // 全局使用同一个processPool
    configuration.processPool = [self processPool];
    
    configuration.userContentController = userContentController;
    // 设置偏好设置
    configuration.preferences = [[WKPreferences alloc] init];
    // 默认为0
    configuration.preferences.minimumFontSize = 10;
    // 默认认为YES
    configuration.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    
    LCAppWebView *wk_webView = [[LCAppWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    
    return wk_webView;
}

- (WKNavigation *)loadRequest:(NSURLRequest *)request{
    
    
    NSString *userAgent = [self valueForKey:@"applicationNameForUserAgent"];
    NSString *string = [NSString stringWithFormat:@"litchon.ios"];
    if(![userAgent containsString:string]){
        [self evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
            NSString *newAgent = [NSString stringWithFormat:@"%@/%@", result, string];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
                self.customUserAgent = newAgent;
            }else{
                [self setValue:newAgent forKey:@"applicationNameForUserAgent"];
            }
            
        }];
    }
    
    request = [self addHeaderWithRequest:request];
    
    
    return [super loadRequest:request];
}

- (NSURLRequest *)addHeaderWithRequest:(NSURLRequest *)request{
    
    //初始化请求
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:request.URL];
    
    //添加到请求头
    [requestObj addValue:[LCAppWebView getCookieString:request.URL] forHTTPHeaderField:@"Cookie"];
    
    return requestObj;
}

+ (NSString *)getCookieString:(NSURL *)url;
{
    if(!url){
        return nil;
    }
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray<NSHTTPCookie *> *cookies = [cookieStorage cookiesForURL:url];
    //cookie 加入字典
    for (NSHTTPCookie *cookie in cookies) {
        [cookieDic setObject:cookie.value forKey:cookie.name];
    }
    // cookie重复，先放到字典进行去重，再进行拼接
    for (NSString *key in cookieDic) {
        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
        [cookieValue appendString:appendString];
    }
    
    if (cookieValue.length) {
        //删除最后一个;
        [cookieValue deleteCharactersInRange:NSMakeRange(cookieValue.length - 1, 1)];
    }
    
    return cookieValue;
}

@end
