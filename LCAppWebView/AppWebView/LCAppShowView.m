//
//  LCAppShowView.m
//  LCDemo
//
//  Created by 雪域科技 on 17/1/5.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppShowView.h"
#define LCAppShowViewBackRadio 0.25
#define LCAppShowViewBjViewAlpha 0.425
#define LCAppScreenWidth [UIScreen mainScreen].bounds.size.width
#define LCAppScreenHeight [UIScreen mainScreen].bounds.size.height

#define IOS8x ([[UIDevice currentDevice].systemVersion floatValue] < 9.0)

@interface LCAppShowView ()<UIScrollViewDelegate>

/**
 方向
 */
@property (nonatomic,assign)LCAppShowViewDirection direction;

/**
 黑色遮盖
 */
@property (nonatomic,weak)UIView *bjView;

/**
 显示的view背景scrollView
 */
@property (nonatomic,strong)UIScrollView *bjScrollView;

/**
 显示的view
 */
@property (nonatomic,strong)UIView *view;

/**
 开始frame
 */
@property (nonatomic,assign)CGRect startFrame;

/**
 结束frame
 */
@property (nonatomic,assign)CGRect endFrame;

/**
 当前是否显示
 */
@property (nonatomic,assign,getter=isShowed)BOOL showed;

@end

@implementation LCAppShowView
+ (instancetype)shareView;
{
    static dispatch_once_t once;
    static LCAppShowView *instance;
    dispatch_once(&once, ^{
        instance = [[LCAppShowView alloc]init];
    });
    return instance;
}

- (UIScrollView *)bjScrollView{
    if (!_bjScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.contentSize = self.frame.size;
        [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bjViewClick)]];
        scrollView.clipsToBounds = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _bjScrollView = scrollView;
    }
    return _bjScrollView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bjViewEnable = YES;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bjViewClick)]];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        UIView *bjView = [[UIView alloc]initWithFrame:self.frame];
        bjView.backgroundColor = [UIColor blackColor];
        bjView.alpha = 0.0;
        [self addSubview:bjView];
        self.bjView = bjView;
    }
    return self;
}

- (void)setPaddingTop:(CGFloat)paddingTop{
    _paddingTop = paddingTop;
    
    CGRect frame = self.bounds;
    frame.origin.y += paddingTop;
    frame.size.height -= paddingTop;
    self.bjView.frame = frame;
}

- (void)bjViewClick{
    if (!self.bjViewEnable) {
        return;
    }
    
    [self hide];
}

- (void)setDirection:(LCAppShowViewDirection)direction{
    _direction = direction;
    
    
    
}

- (void)show;
{
    if (self.isShowed) {
        [self hide];
    }else{
        
        if (self.direction != LCAppShowViewDirectionMiddle) {
            CGAffineTransform transform = CGAffineTransformIdentity;
            if (self.direction == LCAppShowViewDirectionTop) {
                transform = CGAffineTransformMakeTranslation(0, - [UIScreen mainScreen].bounds.size.height + self.endFrame.origin.y);
                
            }else if (self.direction == LCAppShowViewDirectionBottom){
                transform = CGAffineTransformMakeTranslation(0, self.endFrame.origin.y + self.endFrame.size.height);
                
            }else if (self.direction == LCAppShowViewDirectionLeft) {
                transform = CGAffineTransformMakeTranslation( - [UIScreen mainScreen].bounds.size.width + self.endFrame.origin.x, 0);
                
            }else if (self.direction == LCAppShowViewDirectionRight){
                transform = CGAffineTransformMakeTranslation(self.endFrame.size.width + self.endFrame.origin.x, 0.0);
                
            }
            
            [UIView animateWithDuration:0.25 animations:^{
                self.bjView.alpha = LCAppShowViewBjViewAlpha;
                self.view.transform = transform;
            }];
        }else{
            self.view.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                self.bjView.alpha = LCAppShowViewBjViewAlpha;
                self.view.frame = self.endFrame;
                self.view.alpha = 1.0;
            }completion:^(BOOL finished) {
                
            }];
        }
        
        self.showed = YES;
        
    }
    
}

- (void)hide{
    if (self.direction != LCAppShowViewDirectionMiddle) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bjView.alpha = 0.0;
            self.view.transform = CGAffineTransformIdentity;
            
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.view removeFromSuperview];
            [self.bjScrollView removeFromSuperview];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.bjView.alpha = 0.0;
            self.view.frame = self.startFrame;
            self.view.alpha = 0.0;
            
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.view removeFromSuperview];
            [self.bjScrollView removeFromSuperview];
            
        }];
    }
    
    if (self.didHideBlock) {
        self.didHideBlock();
    }
    
    self.showed = NO;
    self.bjViewEnable = YES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.isShowed) {
        
        return;
    }
    CGFloat y = scrollView.contentOffset.y;
    CGFloat x = scrollView.contentOffset.x;
    
    CGFloat alpha = y / self.endFrame.size.height + x / self.endFrame.size.width;
    alpha *= 0.5;
    
    if (self.direction == LCAppShowViewDirectionTop || self.direction == LCAppShowViewDirectionLeft) {
        alpha = MIN(alpha, 0);
    }else if (self.direction == LCAppShowViewDirectionBottom || self.direction == LCAppShowViewDirectionRight){
        alpha = MAX(alpha, 0);
    }else{
        alpha = 0.0;
    }
    
    alpha = LCAppShowViewBjViewAlpha - fabs(alpha);
    
    self.bjView.alpha = alpha;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);
{
    _hide = fabs(velocity.y) >= 1.0;
}

static BOOL _hide = YES;

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGFloat y = scrollView.contentOffset.y;
    CGFloat x = scrollView.contentOffset.x;
    
    if (self.direction == LCAppShowViewDirectionTop) {
        if (y < - self.endFrame.size.height * LCAppShowViewBackRadio) {
            if(_hide){
                [self hide];
            }
        }
        
    }else if (self.direction == LCAppShowViewDirectionBottom){
        if (y > self.endFrame.size.height * LCAppShowViewBackRadio) {
            if(_hide){
                [self hide];
            }
        }
        
    }else if (self.direction == LCAppShowViewDirectionRight){
        if (x > self.endFrame.size.width * LCAppShowViewBackRadio) {
            if(_hide){
                [self hide];
            }
        }
        
    }else if (self.direction == LCAppShowViewDirectionLeft){
        if (x < - self.endFrame.size.width * LCAppShowViewBackRadio) {
            if(_hide){
                [self hide];
            }
        }
        
    }
    
}

+ (void)hide;
{
    [[LCAppShowView shareView] hide];
}

+ (instancetype)showView:(UIView *)view;{
    return [self showView:view withStartFrame:view.frame];
}

+ (instancetype)showView:(UIView *)view withDirection:(LCAppShowViewDirection)direction;
{
    return [self showView:view withEndFrame:view.frame withDirection:direction];
}

+ (instancetype)showView:(UIView *)view withStartFrame:(CGRect)frame;{
    return [self showView:view withEndFrame:frame withDirection:LCAppShowViewDirectionTop];
}

+ (instancetype)showView:(UIView *)view withEndFrame:(CGRect)endRect withDirection:(LCAppShowViewDirection)direction;{
    CGRect startRect;
    
    if (direction == LCAppShowViewDirectionTop) {
        startRect = CGRectMake(endRect.origin.x, [UIScreen mainScreen].bounds.size.height, endRect.size.width, endRect.size.height);
        
    }else if(direction == LCAppShowViewDirectionBottom){
        startRect = CGRectMake(endRect.origin.x, - endRect.size.height, endRect.size.width, endRect.size.height);
        
    }else if (direction == LCAppShowViewDirectionLeft){
        startRect = CGRectMake([UIScreen mainScreen].bounds.size.width, endRect.origin.y, endRect.size.width, endRect.size.height);
        
    }else if (direction == LCAppShowViewDirectionRight){
        startRect = CGRectMake(- endRect.size.width, endRect.origin.y, endRect.size.width, endRect.size.height);
        
    }else if (direction == LCAppShowViewDirectionMiddle){
        CGFloat width = endRect.size.width * 0.0;
        CGFloat height = endRect.size.height * 0.0;
        
        startRect = CGRectMake(endRect.origin.x + (endRect.size.width - width) * 0.5, endRect.origin.y + (endRect.size.height - height) * 0.5, width, height);
    }else{
        startRect = CGRectZero;
    }
    
    return [self showView:view withStartFrame:startRect withEndFrame:endRect withDirection:direction];
}

+ (instancetype)showView:(UIView *)view withStartFrame:(CGRect)startFrame withEndFrame:(CGRect)endFrame withDirection:(LCAppShowViewDirection)direction;{
    LCAppShowView *showView = [LCAppShowView shareView];
    
    if (showView.isShowed) {
        [showView hide];
        return showView;
    }
    
    
    if (direction == LCAppShowViewDirectionTop || direction == LCAppShowViewDirectionBottom) {
        CGFloat padding = 0.5;
        showView.bjScrollView.frame = CGRectMake(0.0, 0.0, showView.frame.size.width, showView.frame.size.height - padding);
        endFrame.size.height += 2 * padding;
        
        startFrame.size.height += 2 * padding;
        
    }else if (direction == LCAppShowViewDirectionLeft || direction == LCAppShowViewDirectionRight){
        CGFloat padding = 0.5;
        showView.bjScrollView.frame = CGRectMake(0.0, 0.0, showView.frame.size.width - padding, showView.frame.size.height);
        endFrame.size.width += 2 * padding;
        endFrame.origin.x -= padding;
        
        startFrame.size.width += 2 * padding;
        startFrame.origin.x -= padding;
        
    }else{
        showView.bjScrollView.frame = CGRectMake(0.0, 0.0, showView.frame.size.width, showView.frame.size.height);
    }
    
    showView.startFrame = startFrame;
    showView.endFrame = endFrame;
    showView.direction = direction;
    showView.view = view;
    
    view.frame = startFrame;
    [showView.bjScrollView addSubview:view];
    
    UIWindow *window = [self showedWindow];
    [window addSubview:showView];
    [window addSubview:showView.bjScrollView];
    
    
    [showView show];
    return showView;
}

+ (UIWindow *)showedWindow{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if(window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows){
            if(tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}
+ (instancetype)showView:(UIView *)view withBlur:(BOOL)blur;
{
    return [self showView:view withDirection:LCAppShowViewDirectionTop withBlur:blur];
}
+ (instancetype)showView:(UIView *)view withDirection:(LCAppShowViewDirection)direction withBlur:(BOOL)isBlur;
{
    if (!isBlur) {
        return [LCAppShowView showView:view withDirection:direction];
    }
    
    CGFloat paddingX = 15.0;
    CGFloat height = view.frame.size.height;
    CGRect frame = CGRectMake(paddingX, LCAppScreenHeight - height - paddingX, LCAppScreenWidth - 2 * paddingX, height);
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    effectview.frame = frame;
    effectview.layer.cornerRadius = 5.0;
    effectview.clipsToBounds = YES;
    view.frame = effectview.bounds;
    
    CGFloat alpha = 0.33;
    if (IOS8x) {
        alpha = 0.85;
    }
    view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:alpha];
    
    [effectview.contentView addSubview:view];
    
    return [LCAppShowView showView:effectview withDirection:direction];
}

@end
