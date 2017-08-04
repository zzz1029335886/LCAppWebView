//
//  LCAppWebViewNavigationConfig.m
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewNavigationConfig.h"

@implementation LCAppWebViewNavigationConfig
+ (instancetype)configWithUrlString:(NSString *)urlString;
{
    
    NSString *lcNavBase = [self getResultWithUrlParams:@"lcNavBase" urlString:urlString];
    return [self configWithString:lcNavBase];
    
}

+ (instancetype)configWithString:(NSString *)lcNavBase{
    if(lcNavBase.length == 8){
        
        LCAppWebViewNavigationConfig *config = [[LCAppWebViewNavigationConfig alloc]init];
        config.hidden = [[lcNavBase substringWithRange:NSMakeRange(0, 1)] boolValue];
        config.whiteTitle = [[lcNavBase substringWithRange:NSMakeRange(1, 1)] boolValue];
        config.colorString = [lcNavBase substringWithRange:NSMakeRange(2, 6)];
        
        [[NSUserDefaults standardUserDefaults] setObject:lcNavBase forKey:@"LCWebViewNavigationBarConfig"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return config;
        
    }else if(lcNavBase.length > 8){
        
        LCAppWebViewNavigationConfig *config = [[LCAppWebViewNavigationConfig alloc]init];
        config.hidden = [[lcNavBase substringWithRange:NSMakeRange(0, 1)] boolValue];
        config.whiteTitle = [[lcNavBase substringWithRange:NSMakeRange(1, 1)] boolValue];
        config.colorString = [lcNavBase substringWithRange:NSMakeRange(2, 6)];
        config.rightButtonTitle = [lcNavBase substringWithRange:NSMakeRange(8, lcNavBase.length - 8)];
        
        [[NSUserDefaults standardUserDefaults] setObject:lcNavBase forKey:@"LCWebViewNavigationBarConfig"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return config;
        
    }else{
        LCAppWebViewNavigationConfig *config = [[LCAppWebViewNavigationConfig alloc]init];
        config.hidden = NO;
        config.whiteTitle = NO;
        config.colorString = @"ffffff";
        return config;
        
        NSString *string = [[NSUserDefaults standardUserDefaults] valueForKey:@"LCWebViewNavigationBarConfig"];
        if(string && string.length >= 8){
            return [self configWithString:string];
        }else{
            LCAppWebViewNavigationConfig *config = [[LCAppWebViewNavigationConfig alloc]init];
            config.hidden = NO;
            config.whiteTitle = NO;
            config.colorString = @"ffffff";
            return config;
        }
        
    }
}

@end
