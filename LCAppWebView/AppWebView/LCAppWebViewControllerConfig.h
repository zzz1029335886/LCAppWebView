//
//  LCAppWebViewControllerConfig.h
//  LCAppWebView
//
//  Created by 凌创科技 on 2017/7/29.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewConfig.h"

@interface LCAppWebViewControllerConfig : LCAppWebViewConfig
/**
 进度条颜色
 */
@property (nonatomic,strong)NSString *progressColorString;

/**
 是否下拉刷新
 */
@property (nonatomic,assign)BOOL hasRefresh;

/**
 是否返回顶部
 */
@property (nonatomic, assign)BOOL hasBackButton;

/**
 根据URL字符串创建对象
 
 @param urlString URL字符串
 @return 对象
 */
+ (instancetype)configWithUrlString:(NSString *)urlString;

@end
