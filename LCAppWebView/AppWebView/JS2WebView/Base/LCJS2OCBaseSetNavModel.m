//
//  LCJS2OCBaseOpenUrlModel.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/17.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCBaseSetNavModel.h"
#import "LCAppWebViewController.h"
#import "LCAppWebViewController+OC2JS.h"
#import "LCAPPShowTableView.h"
#define LCAppScreenWidth [UIScreen mainScreen].bounds.size.width
#define LCAppScreenHeight [UIScreen mainScreen].bounds.size.height
@interface LCSetNavButton : UIButton

@end

@implementation LCSetNavButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(self.frame.size.width * 0.25, self.frame.size.height * 0.25, self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}
@end

@interface LCJS2OCBaseSetNavModel()<LCAppShowTableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)LCSetNavButton *button;
@property (nonatomic,strong)LCAppShowTableView *showTableView;
@property (nonatomic,strong)LCJS2OCModel *model;
@end

@implementation LCJS2OCBaseSetNavModel
+ (void)openUrlWithModel:(LCJS2OCModel *)model;
{
    NSString *url = (NSString *)[model.model url];
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    LCAppWebViewController *controller = [[LCAppWebViewController alloc]initWithUrlString:urlString];
    [model.controller.navigationController pushViewController:controller animated:YES];
}

+ (void)setNavWithModel:(LCJS2OCModel *)model;
{
    LCJS2OCBaseSetNavModel *setNavModel = model.model;
    
    if(setNavModel == nil){
        model.controller.navigationItem.rightBarButtonItem = nil;
        return;
    }
    
    LCSetNavButton *button = [[LCSetNavButton alloc]init];
    setNavModel.button = button;
    
    if(setNavModel.rightTitle){
        CGFloat width = [setNavModel.rightTitle boundingRectWithSize:CGSizeMake(LCAppScreenWidth * 0.5, 44.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil].size.width + 5.0;
        button.frame = CGRectMake(0.0, 10.0, width, 24.0);
        
        [button setTitle:setNavModel.rightTitle forState:UIControlStateNormal];
        
        if(model.controller.navigationConfig.whiteTitle){
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        }else{
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        }
        [button addTarget:model.controller action:@selector(rightNavBarClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(setNavModel.rightTitles){
        CGFloat width = 35.0;
        button.frame = CGRectMake(0.0, 10.0, width, 35.0);
        
        if(model.controller.navigationConfig.whiteTitle){
            [button setImage:[UIImage imageNamed:@"btn_more_white.png"] forState:UIControlStateNormal];
        }else{
            [button setImage:[UIImage imageNamed:@"btn_more_black.png"] forState:UIControlStateNormal];
        }
        [button addTarget:setNavModel action:@selector(showRightTitles) forControlEvents:UIControlEventTouchUpInside];
        
        _model = setNavModel;
        _model.model = model;
        _model.model.controller.webView.scrollView.delegate = setNavModel;
    }
    
    model.controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

static LCJS2OCBaseSetNavModel *_model = nil;

- (void)showRightTitles{
    
    if(self.showTableView == nil) {
        NSArray *arr = self.rightTitles;
        //        NSArray *arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"btn_home1"], [UIImage imageNamed:@"detail_share"], [UIImage imageNamed:@"btn_follow"], nil];
        
        CGFloat height = 40.0 * arr.count + 10.0;
        CGFloat width = LCAppScreenWidth * 0.33;
        CGFloat y = 0.0;
        CGFloat x = LCAppScreenWidth - width;
        
        self.showTableView = [[LCAppShowTableView alloc]showTableViewToView:self.model.controller.view endRect:CGRectMake(x, y, width, height) titleArry:arr imageArry:nil direction:LCAppShowTableViewDirectionTopRight];
        self.showTableView.delegate = self;
        [self.model.controller.view addSubview:self.showTableView];
    }else {
        [self.showTableView hide];
        self.showTableView = nil;
    }
}
#pragma mark - ZZZShowTableViewDelegate

- (void)showTableViewDelegateMethod:(ZZZShowTableView *)sender selectedIndex:(NSInteger)index{
    
    [self.model.controller rightNavBarClickWithTitle:self.rightTitles[index]];
    
    sender = nil;

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(fabs(velocity.y) > 0.3){
        [self.showTableView hide];
        self.showTableView = nil;
    }
    
}

@end
