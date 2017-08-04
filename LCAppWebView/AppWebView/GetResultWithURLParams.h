//
//  GetResultWithURLParams.h
//  PYPin
//
//  Created by 雪域科技 on 16/12/27.
//  Copyright © 2016年 com.litchon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetResultWithURLParams : NSObject

/**
 根据参数获取URL字符串中的值

 @param CS 参数
 @param urlString URL字符串
 @return 结果
 */
+ (NSString *)getResultWithUrlParams:(NSString *)CS urlString:(NSString *)urlString;


/**
 根据URL字符串判断是否重定向

 @param urlString URL字符串
 @return 是否
 */
+ (BOOL)isOpenWindowWithUrlString:(NSString *)urlString;


/**
 判断是否商品详情

 @param string URL字符串
 @return 是否
 */
+ (BOOL)isProductDeatilView:(NSString *)string;


/**
 根据URL字符串获取“结束”事件

 @param urlString URL字符串
 @return 事件类型
 */
+ (int)finishValueWithUrlString:(NSString *)urlString;

@end
