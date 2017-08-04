//
//  LCJS2OCThird.h
//  kryb
//
//  Created by 凌创科技 on 2017/7/18.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCJS2OCThirdModel.h"
@interface LCJS2OCThird : NSObject
@property (nonatomic,strong)NSDictionary *shareParams;
//title,text,url,imgUrl,scene:1,2,3
+ (void)handleWithModel:(LCJS2OCThirdModel *)model;

@end

@interface LCJS2OCThirdShareParams : NSObject

@end
