//
//  LCTopWindowViewController.m
//  LCTopWindowViewController
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCTopWindowViewController.h"

@interface LCTopWindowViewController ()
@property (nonatomic,weak)UILabel *label;

@end

@implementation LCTopWindowViewController
#pragma mark - 单例
static id instance_;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 20.0)];
    label.font = [UIFont systemFontOfSize:12.0];
    label.textAlignment = NSTextAlignmentCenter;
    
    if(self.statusBarStyle == UIStatusBarStyleDefault){
        label.textColor = [UIColor blackColor];
    }else{
        label.textColor = [UIColor whiteColor];
    }
    
    [self.view addSubview:label];
    self.label = label;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - 状态栏控制
- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

#pragma mark - setter
- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    [[UIApplication sharedApplication] setStatusBarHidden:statusBarHidden];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

+ (void)showWithTitle:(NSString *)title;
{
    [self showWithTitle:title timeInterval:2.0];
}
+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval;
{
    [self showWithTitle:title timeInterval:timeInterval backgroundColor:[UIColor whiteColor]];
}
+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval backgroundColorString:(NSString *)colorString;
{
    [self showWithTitle:title timeInterval:timeInterval backgroundColor:[self colorWithHexCode:colorString]];
}
+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval backgroundColorString:(NSString *)colorString titleColor:(UIColor *)titleColor;
{
    [self showWithTitle:title timeInterval:timeInterval backgroundColor:[self colorWithHexCode:colorString] titleColor:titleColor];
}
+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval backgroundColor:(UIColor *)color titleColor:(UIColor *)titleColor;
{
    LCTopWindowViewController *topVc = [LCTopWindowViewController sharedInstance];
    topVc.label.text = title;
    topVc.label.backgroundColor = color;
    topVc.label.textColor = titleColor;
    [UIView animateWithDuration:0.25 animations:^{
        topVc.label.alpha = 1.0;
        
    }completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                topVc.label.alpha = 0.0;
                
            }completion:^(BOOL finished) {
                
            }];
        });
    }];
}
+ (void)showWithTitle:(NSString *)title timeInterval:(NSTimeInterval)timeInterval backgroundColor:(UIColor *)color;
{
    [self showWithTitle:title timeInterval:timeInterval backgroundColor:color titleColor:[UIColor blackColor]];
}

+ (UIColor *)colorWithHexCode:(NSString *)hexCode
{
    if (!hexCode.length) {
        return nil;
    }
    NSString *cleanString = [hexCode stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
