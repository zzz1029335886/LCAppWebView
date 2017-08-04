//
//  LCAppShowTableView.h
//  DBao
//
//  Created by 雪域科技 on 16/6/13.
//  Copyright © 2016年 雪域科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    LCAppShowTableViewDirectionTop = 0, //上
    LCAppShowTableViewDirectionBottom = 1, //下
    LCAppShowTableViewDirectionLeft = 2,//左
    LCAppShowTableViewDirectionRight = 3,//右
    LCAppShowTableViewDirectionNone = 4,//无
    LCAppShowTableViewDirectionTopRight = 5,//右上
} LCAppShowTableViewDirection;

@class LCAppShowTableView;
@protocol LCAppShowTableViewDelegate <NSObject>
@optional
- (void)showTableViewDelegateMethod: (LCAppShowTableView *)sender selectedIndex:(NSInteger)index;
@end

@interface LCAppShowTableView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,weak)UIImageView *imgView;
@property (nonatomic,weak) id<LCAppShowTableViewDelegate> delegate;
@property (nonatomic,assign)LCAppShowTableViewDirection direction;
@property (nonatomic,assign)LCAppShowTableViewDirection backDirection;

- (void)hide;

- (instancetype)showTableViewToView:(UIView *)view endRect:(CGRect)endRect titleArry:(NSArray *)arr imageArry:(NSArray *)imgArr direction:(LCAppShowTableViewDirection)direction;

- (instancetype)showTableViewToView:(UIView *)view endRect:(CGRect)endRect titleArry:(NSArray *)arr imageArry:(NSArray *)imgArr direction:(LCAppShowTableViewDirection)direction backDirection:(LCAppShowTableViewDirection)backDirection;

@end
