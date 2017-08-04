//
//  LCAppShowView.h
//  TextDemo
//
//  Created by LiGuo.Huang on 16/4/30.
//  Copyright © 2016年 com.SnowyBlade.xg. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    LCAppShowViewDirectionTop = 0, //上
    LCAppShowViewDirectionBottom = 1, //下
    LCAppShowViewDirectionLeft = 2,//左
    LCAppShowViewDirectionRight = 3,//右
    LCAppShowViewDirectionMiddle = 4,//无
    
} LCAppShowViewDirection;

@interface LCAppShowView : UIView

/**
 bjView距离上面距离
 */
@property (nonatomic,assign)CGFloat paddingTop;

/**
 是否可点击
 */
@property (nonatomic,assign)BOOL bjViewEnable;

/**
 隐藏后的回调
 */
@property (nonatomic,copy)void (^didHideBlock)();

/**
 单利创建

 @return 对象
 */
+ (instancetype)shareView;

/**
 隐藏
 */
+ (void)hide;

+ (instancetype)showView:(UIView *)view;
+ (instancetype)showView:(UIView *)view withDirection:(LCAppShowViewDirection)direction;


/**
 显示view是否有高斯模糊

 @param view 显示的view
 @param blur 是否模糊
 @return 单利对象
 */
+ (instancetype)showView:(UIView *)view withBlur:(BOOL)blur;
+ (instancetype)showView:(UIView *)view withDirection:(LCAppShowViewDirection)direction withBlur:(BOOL)blur;

@end
