//
//  LCAppWebViewNavigationConfig.h
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewConfig.h"

@interface LCAppWebViewNavigationConfig : LCAppWebViewConfig
/**
 导航栏颜色
 */
@property (nonatomic,strong)NSString *colorString;

/**
 导航栏隐藏
 */
@property (nonatomic,assign)BOOL hidden;

/**
 白色标题
 */
@property (nonatomic, assign)BOOL whiteTitle;

/**
 导航栏颜色
 */
@property (nonatomic,strong)NSString *rightButtonTitle;

/**
 根据URL字符串创建对象
 
 @param urlString URL字符串
 @return 对象
 */
+ (instancetype)configWithUrlString:(NSString *)urlString;

@end
