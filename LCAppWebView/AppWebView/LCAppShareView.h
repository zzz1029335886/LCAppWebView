//
//  LCShareView.h
//  PYPin
//
//  Created by 雪域科技 on 16/12/27.
//  Copyright © 2016年 com.litchon. All rights reserved.
//

//#import "LCWeChatShare.h"
//#import "LCTencentShare.h"
#import <UIKit/UIKit.h>

@interface LCAppShareView : UIView
typedef enum{
    LCShareViewTypeWeChatFriend  = 0,        /**< 微信好友    */
    LCShareViewTypeWeChatZone = 1,           /**< 朋友圈      */
    LCShareViewTypeWeChatFavorite = 2,       /**< 微信收藏    */
    LCShareViewTypeQQFriend = 3,             /**< 微信收藏    */
    LCShareViewTypeQQZone = 4,               /**< 微信收藏    */
} LCShareViewType;

@property (nonatomic,copy)void (^clickBlock)(LCShareViewType type);

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withImages:(NSArray *)images;

+ (void)showShareViewWithCompleteBlock:(void(^)(LCShareViewType type))completeBlock;

@end
