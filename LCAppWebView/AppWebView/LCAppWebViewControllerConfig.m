//
//  LCAppWebViewControllerConfig.m
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewControllerConfig.h"

@implementation LCAppWebViewControllerConfig
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)configWithUrlString:(NSString *)urlString;
{
    
    NSString *lcConBase = [self getResultWithUrlParams:@"lcConBase" urlString:urlString];
    return [self configWithString:lcConBase];
}

+ (instancetype)configWithString:(NSString *)lcConBase{
    if(lcConBase.length >= 8){
        
        LCAppWebViewControllerConfig *config = [[LCAppWebViewControllerConfig alloc]init];
        config.hasRefresh = [[lcConBase substringWithRange:NSMakeRange(0, 1)] boolValue];
        config.hasBackButton = [[lcConBase substringWithRange:NSMakeRange(1, 1)] boolValue];
        config.progressColorString = [lcConBase substringWithRange:NSMakeRange(2, 6)];
        
        [[NSUserDefaults standardUserDefaults] setObject:lcConBase forKey:@"LCWebViewControllerConfig"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return config;
        
    }else{
        LCAppWebViewControllerConfig *config = [[LCAppWebViewControllerConfig alloc]init];
        config.hasRefresh = NO;
        config.hasBackButton = NO;
        config.progressColorString = @"333333";
        return config;
        
        NSString *string = [[NSUserDefaults standardUserDefaults] valueForKey:@"LCWebViewControllerConfig"];
        if(string && string.length >= 8){
            return [self configWithString:string];
        }else{
            LCAppWebViewControllerConfig *config = [[LCAppWebViewControllerConfig alloc]init];
            config.hasRefresh = NO;
            config.hasBackButton = NO;
            config.progressColorString = @"ffffff";
            return config;
        }
        
    }
}

@end
