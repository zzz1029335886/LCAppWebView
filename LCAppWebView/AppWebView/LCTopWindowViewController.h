//
//  LCTopWindowViewController.h
//  LCTopWindowViewController
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LCHideStatusBar [LCTopWindowViewController sharedInstance].statusBarHidden = YES;
#define LCShowStatusBar [LCTopWindowViewController sharedInstance].statusBarHidden = NO;
#define LCBlackStatusBar [LCTopWindowViewController sharedInstance].statusBarStyle = UIStatusBarStyleDefault;
#define LCWhiteStatusBar [LCTopWindowViewController sharedInstance].statusBarStyle = UIStatusBarStyleLightContent;

@interface LCTopWindowViewController : UIViewController
+ (instancetype)sharedInstance;

+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval backgroundColorString:(NSString *)colorString titleColor:(UIColor *)titleColor;
+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval backgroundColorString:(NSString *)colorString;
+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval backgroundColor:(UIColor *)color;
+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval;
+ (void)showWithTitle:(NSString *)title;

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@end
