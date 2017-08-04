//
//  LCJS2OCCommonUploadImageModel.h
//  kryb
//
//  Created by 凌创科技 on 2017/6/20.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCJS2OCModel.h"
typedef void(^UploadImageBlock)(BOOL success,NSString *imageId);
@interface LCJS2OCCommonUploadImageModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)NSInteger count;

+ (void)uploadImageWithModel:(LCJS2OCModel *)model withCompleteBlock:(UploadImageBlock)uploadImageBlock;


@end
