//
//  LCJS2OCModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/4.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "LCAppWebViewController.h"

// 枚举上传图片类型
typedef enum : NSUInteger {
    LCJS2OCModelTypeNone = 0,//无
    LCJS2OCModelTypeBase,//基本
    LCJS2OCModelTypeCommon,//公共
    LCJS2OCModelTypeThird,//第三方
    LCJS2OCModelTypeKryb,//快人易步
    
} LCJS2OCModelType;


@interface LCJS2OCModel : NSObject
/**
 控制器
 */
@property (nonatomic,strong,readonly)LCAppWebViewController *controller;

/**
 方法名
 */
@property (nonatomic,copy)NSString *action;

/**
 model
 */
@property (nonatomic,strong)id model;

/**
 类型
 */
@property (nonatomic,assign)int actionType;

/**
 类型
 */
@property (nonatomic,assign)LCJS2OCModelType type;
- (void)setController:(LCAppWebViewController *)controller;

+ (instancetype)modelWithType:(LCJS2OCModelType)type withDictionary:(NSDictionary *)dict;

+ (instancetype)modelWithType:(LCJS2OCModelType)type withDictionary:(NSDictionary *)dict withViewController:(UIViewController *)controller;

@end
