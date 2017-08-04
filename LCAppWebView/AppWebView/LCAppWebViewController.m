//
//  LCAppWebViewController.m
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewController.h"
#import "LCAppWebViewController+JS.h"

#import "UIColor+LCAppWebView.h"
#import <MJRefresh/MJRefresh.h>
#import "GetResultWithURLParams.h"

@interface LCAppWebViewController ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger isDefaultWebview;

@end

@implementation LCAppWebViewController

- (instancetype)initWithUrl:(NSURL *)url;{
    self = [super init];
    if (self) {
        self.url = url;
        self.urlString = url.absoluteString;
    }
    return self;
}

- (instancetype)initWithUrlString:(NSString *)urlString;{
    self = [super init];
    if (self) {
        self.url = [[NSURL alloc]initWithString:urlString];
        self.urlString = urlString;
    }
    return self;
}

- (void)setUrlString:(NSString *)urlString;{
    _urlString = urlString;
    
    NSString *string4 = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.navigationConfig = [LCAppWebViewNavigationConfig configWithUrlString:string4];
    self.controllerConfig = [LCAppWebViewControllerConfig configWithUrlString:string4];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupWebView];
    
    [self setupControllerConfig];
    [self setupNavigationConfig];

}

- (void)setupWebView{
    CGFloat webViewX = 0.0;
    CGFloat webViewY = -64.0;
    CGFloat webViewWidth = self.view.frame.size.width;
    CGFloat webViewHeight = self.view.frame.size.height;
    
    CGFloat progressViewY = 0.0;
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0.0, progressViewY, self.view.frame.size.width, 0)];
    progressView.tintColor = [UIColor colorWithHexCode:self.controllerConfig.progressColorString];
    progressView.trackTintColor = [UIColor clearColor];
    progressView.transform = CGAffineTransformMakeScale(1.0,2.0);
    
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    LCAppWebView *webView = [LCAppWebView webView];
    webView.frame = CGRectMake(webViewX, webViewY, webViewWidth, webViewHeight);
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.contentInset = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);
    
    NSString *cookieString = [NSString stringWithFormat:@"doucument.cookir='%@'",[LCAppWebView getCookieString:self.url]];

    WKUserScript *userScript = [[WKUserScript alloc]initWithSource:cookieString
                                                     injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                  forMainFrameOnly:NO];
    
    [webView.configuration.userContentController addUserScript:userScript];
    
    [self.view insertSubview:webView belowSubview:progressView];
    self.webView = webView;
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.delegate = self;
    [self addScriptMessageHandler];
    
    if(self.controllerConfig.hasRefresh){
        self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.webView reload];
        }];
    }
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    NSURL *url = self.url;
    if (!url) {
        url = [NSURL URLWithString:self.urlString];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)setupControllerConfig{
    if(self.controllerConfig.hasRefresh){
        self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.webView reload];
        }];
    }
    
    if(self.controllerConfig.hasBackButton){
        
    }
    
    if(self.controllerConfig.progressColorString){
        self.progressView.tintColor = [UIColor colorWithHexCode:self.controllerConfig.progressColorString];
    }
}

- (void)setupNavigationConfig{
    
    
    
}

#pragma mark - KVO
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
            
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
            
        }
        
    }else if(object == self.webView && [keyPath isEqualToString:@"title"]){
        
        NSString *string = @"litchon";
        NSString *title = self.webView.title;
        if([title containsString:string]){
            title = [title substringToIndex:title.length - string.length];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            self.title = title;
        }];
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self didReceiveScriptMessage:message];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    completionHandler();
}

#pragma mark - WKNavigationDelegate

- (void)webView:(LCAppWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
    NSURL *URL = navigationAction.request.URL;
    NSString *urlString = URL.absoluteString;
    
    //    NSLog(@"self.urlString = %@",self.urlString);
    NSLog(@"     urlString = %@",urlString);
    
    //    if (self.webView.flag) {
    //        decisionHandler(WKNavigationActionPolicyAllow);
    //        return;
    //    }
    //重定向时，并且刷新，才不跳转
    if ([navigationAction.request.HTTPMethod isEqualToString:@"POST"] || [urlString containsString:@".95516.com/"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    //重定向时，并且刷新，才不跳转
    if ([urlString isEqualToString:self.urlString]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    if (self.isDefaultWebview) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    if ([GetResultWithURLParams isOpenWindowWithUrlString:urlString]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    
    LCAppWebViewController *webViewVc = [[LCAppWebViewController alloc]initWithUrl:URL];
    webViewVc.isDefaultWebview = [GetResultWithURLParams getResultWithUrlParams:@"IsDefaultWebview" urlString:urlString].integerValue;
    [self.navigationController pushViewController:webViewVc animated:YES];
    decisionHandler(WKNavigationActionPolicyCancel);
    
    
}



- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;
{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

- (void)webView:(LCAppWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    if(![navigationResponse.response isKindOfClass:[NSHTTPURLResponse class]]){
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    // 获取cookie,并设置到本地
    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    NSDictionary *cookieDicts = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    
    for (NSString *string in cookieDicts.allKeys) {
        NSLog(@"key : value = %@ : %@",string,cookieDicts[string]);
    }
    
    for (NSHTTPCookie *cookie in cookies) {
        NSLog(@"%@",cookie.name);
        NSLog(@"%@",cookie.value);
        NSLog(@"%@",cookie.expiresDate);
        
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//
//    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
//
//    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
//
//    for (NSHTTPCookie *cookie in cookies) {
//
//        //每次都存最新的sessionId
//
//        [SettingBaseTool deleteDatasByKey:[cookie name]];
//
//        [SettingBaseTool saveBaseInfoStringWithKey:[cookie name] value:[cookie value] isDelayUserId:NO];
//
//    }
//}

- (void)webView:(LCAppWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
{
    
}

- (void)webView:(LCAppWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
{
//    [self.webView requestFaield];
    
    if (self.controllerConfig.hasRefresh && self.webView.scrollView.mj_header.isRefreshing) {
        [self.webView.scrollView.mj_header endRefreshing];
    }
}

- (void)webView:(LCAppWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    if (self.controllerConfig.hasRefresh && self.webView.scrollView.mj_header.isRefreshing) {
        [self.webView.scrollView.mj_header endRefreshing];
    }
//    [self.webView removeFaieldLabel];
}


// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
@end
