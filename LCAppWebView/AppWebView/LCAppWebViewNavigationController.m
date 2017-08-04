//
//  LCAppWebViewNavigationController.m
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewNavigationController.h"
#import "LCTopWindowViewController.h"

@interface LCAppWebViewNavigationController ()

@end

@implementation LCAppWebViewNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar{
    // 取出appearance对象
    UINavigationBar *navBar = self.navigationBar;
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.firstViewAppera = NO;
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    self.firstViewAppera = NO;
    return [super popViewControllerAnimated:animated];
}

- (void)back
{
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.firstViewAppera = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(self.statusBarStyle == UIStatusBarStyleDefault){
        LCBlackStatusBar
    }else{
        LCWhiteStatusBar
    }
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:self.barItemTextAttributes forState:UIControlStateNormal];
}

@end
