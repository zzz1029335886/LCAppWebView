
//
//  GetResultWithURLParams.m
//  PYPin
//
//  Created by 雪域科技 on 16/12/27.
//  Copyright © 2016年 com.litchon. All rights reserved.
//

#import "GetResultWithURLParams.h"

@implementation GetResultWithURLParams
+ (NSString *)getResultWithUrlParams:(NSString *)CS urlString:(NSString *)urlString;
{
    if (!urlString) {
        return nil;
    }
    NSError *error;
    NSString *regTags = [[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",CS];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    
    // NSString *webaddress=@"http://wgpc.wzsafety.gov.cn/dd/adb.htm?adc=e12&xx=lkw&dalsjd=12";
    NSArray *matches = [regex matchesInString:urlString
                                      options:0
                                        range:NSMakeRange(0, [urlString length])];
    for (NSTextCheckingResult *match in matches) {
        //NSRange matchRange = [match range];
        //NSString *tagString = [webaddress substringWithRange:matchRange];  // 整个匹配串
        //        NSRange r1 = [match rangeAtIndex:1];1
        //        if (!NSEqualRanges(r1, NSMakeRange(NSNotFound, 0))) {    // 由时分组1可能没有找到相应的匹配，用这种办法来判断
        //            //NSString *tagName = [webaddress substringWithRange:r1];  // 分组1所对应的串
        //            return @"";
        //        }
        
        NSString *tagValue = [urlString substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        //    NSLog(@"分组2所对应的串:%@/n",tagValue);
        return tagValue;
    }
    return nil;
}

+ (BOOL)isOpenWindowWithUrlString:(NSString *)urlString;
{
    return [[self getResultWithUrlParams:@"OpenWindow" urlString:urlString] isEqualToString:@"0"];
}
+ (int)finishValueWithUrlString:(NSString *)urlString;
{
    return [[self getResultWithUrlParams:@"finish" urlString:urlString] intValue];
}

+ (BOOL)isProductDeatilView:(NSString *)string;
{
    NSArray *array1 = [string componentsSeparatedByString:@"?"];
    
    if (array1.count) {
        NSArray *array2 = [array1.firstObject componentsSeparatedByString:@"/"];
        
        if (array2.count >= 2) {
            if ([array2.lastObject isEqualToString:@"DetailGroup"]) {
                
                return YES;
            }
        }
    }
    return NO;
}
@end
