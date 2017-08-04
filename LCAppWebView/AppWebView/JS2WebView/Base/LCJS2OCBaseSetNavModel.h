//
//  LCJS2OCBaseOpenUrlModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/17.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCModel.h"
@class ZZZShowTableView;
@interface LCJS2OCBaseSetNavModel : NSObject
@property (nonatomic,strong)NSString *rightTitle;
@property (nonatomic,strong)NSArray<NSString *> *rightTitles;

+ (void)setNavWithModel:(LCJS2OCModel *)model;

@end
