//
//  ViewController.m
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "ViewController.h"
#import "LCAppWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"网页" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];

}

- (void)rightClick{
    NSString *homeUrlStr = [[NSString stringWithFormat:@"http://web.litchon.com/litchon/m/default/Index.html?pageUrl=home/index.html&isShowNav=0"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    LCAppWebViewController *controller = [[LCAppWebViewController alloc]initWithUrlString:homeUrlStr];
    
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
