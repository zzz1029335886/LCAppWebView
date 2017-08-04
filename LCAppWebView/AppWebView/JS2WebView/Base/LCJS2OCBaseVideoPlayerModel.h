//
//  LCJS2OCBaseVideoPlayerModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/5.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCJS2OCBaseVideoPlayerModel : NSObject
@property (nonatomic,copy)NSString *url;

+ (void)playWithModel:(LCJS2OCBaseVideoPlayerModel *)model;

@end
