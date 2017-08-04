//
//  LCJS2OCBaseImageBrowserModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/5.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCModel.h"

@interface LCJS2OCBaseImageBrowserModel : NSObject
@property (nonatomic,strong)NSArray *urls;
@property (nonatomic,assign)NSInteger currentIndex;

+ (void)show:(LCJS2OCModel *)model;

@end
