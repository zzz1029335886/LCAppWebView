//
//  LCJS2OCThirdShareModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/7/19.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCThird.h"

@interface LCJS2OCThirdShareModel : LCJS2OCThird
+ (void)shareWithModel:(LCJS2OCThirdModel *)model withBlock:(void(^)(BOOL success))block;
                                                                  
@end
