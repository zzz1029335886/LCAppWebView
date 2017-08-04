//
//  LCShareView.m
//  PYPin
//
//  Created by 雪域科技 on 16/12/27.
//  Copyright © 2016年 com.litchon. All rights reserved.
//

#import "LCAppShareView.h"
#import "LCAppShowView.h"
#define LCAppScreenWidth [UIScreen mainScreen].bounds.size.width
#define LCAppScreenHeight [UIScreen mainScreen].bounds.size.height

#define LCShareViewButtonImageRatio 0.7
@interface LCShareViewButton : UIButton

@end

@implementation LCShareViewButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //    CGFloat padding = 10.0;
    self.imageView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height * 0.5);
    self.titleLabel.frame = CGRectMake(0.0, self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height * 0.5);
    
    
}
@end

@interface LCAppShareView()

@property (nonatomic,weak)UILabel *titleLabel;
@property (nonatomic,weak)UIView *buttonsView;
@property (nonatomic,weak)UIView *lineView;

@end

@implementation LCAppShareView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withImages:(NSArray *)images;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"分享选择";
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.3;
        [self addSubview:lineView];
        self.lineView = lineView;
        
        UIView *view = [[UIView alloc]init];
        for (int i = 0; i<titles.count; i++) {
            LCShareViewButton *button = [[LCShareViewButton alloc]init];
            button.tag = i;
            [button setTitle:titles[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13.0];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
        
        [self addSubview:view];
        self.buttonsView = view;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame;
{
    return [self initWithFrame:frame withTitles:@[@"微信好友",@"朋友圈",@"微信收藏"] withImages:@[@"senter_weixin",@"senter_pengyouquan",@"senter_shoucang",@"senter_qq",@"senter_kongjian"]];
}

- (void)buttonClick:(UIButton *)button
{
    LCShareViewType type = LCShareViewTypeWeChatFriend;
    if ([button.titleLabel.text isEqualToString:@"微信好友"]) {
        type = LCShareViewTypeWeChatFriend;
        
    }else if ([button.titleLabel.text isEqualToString:@"朋友圈"]){
        type = LCShareViewTypeWeChatZone;

    }else if ([button.titleLabel.text isEqualToString:@"微信收藏"]){
        type = LCShareViewTypeWeChatFavorite;

    }else if ([button.titleLabel.text isEqualToString:@"QQ好友"]){
        type = LCShareViewTypeQQFriend;

    }else if ([button.titleLabel.text isEqualToString:@"QQ空间"]){
        type = LCShareViewTypeQQZone;

    }
    
    if (self.clickBlock) {
        self.clickBlock(type);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat labelHeight = 44.0;
    
    CGFloat buttonWidth = 70.0;
    CGFloat buttonPaddingX = (width - buttonWidth * self.buttonsView.subviews.count) / (self.buttonsView.subviews.count + 1);
    CGFloat buttonViewHeight = height - labelHeight;
    CGFloat buttonHeight = buttonWidth;
    CGFloat buttonPaddingY = (buttonViewHeight - buttonHeight) * 0.5;

    self.titleLabel.frame = CGRectMake(0.0, 0.0, width, labelHeight);
    self.lineView.frame = CGRectMake(0.0, labelHeight, width, 1.0);
    self.buttonsView.frame = CGRectMake(0.0, labelHeight + 1.0, width, buttonViewHeight);
    for (LCShareViewButton *button in self.buttonsView.subviews) {
        button.frame = CGRectMake(button.tag * (buttonWidth + buttonPaddingX) + buttonPaddingX, buttonPaddingY, buttonWidth, buttonHeight);
    }
}

+ (void)showShareViewWithCompleteBlock:(void(^)(LCShareViewType type))completeBlock;
{
    CGFloat height = 160.0;
    CGFloat paddingX = 0.0;
    
    LCAppShareView *shareView = [[LCAppShareView alloc]initWithFrame:CGRectMake(paddingX, LCAppScreenHeight - height - paddingX, LCAppScreenWidth - 2 * paddingX, height)];
    
    shareView.clickBlock = ^(LCShareViewType type){
        if (completeBlock) {
            completeBlock(type);
        }
        [LCAppShowView hide];
    };
    
    [LCAppShowView showView:shareView withBlur:YES];
}

@end
