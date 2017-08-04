//
//  LCWebViewController+JS.m
//  LCWebView
//
//  Created by 凌创科技 on 2017/6/9.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCAppWebViewController+JS.h"

#import "LCJS2OCBaseModel.h"
//#import "LCJS2OCCommonModel.h"
#import "LCJS2OCThirdModel.h"

#import "LCJS2OCThirdWechatModel.h"
#import "LCJS2OCThirdWechatModel.h"
#import "LCJS2OCThirdAliModel.h"
#import "LCJS2OCThirdQQModel.h"
#import "LCJS2OCThirdShareModel.h"

#import "LCAppWebViewController+OC2JS.h"

//#import "LCCommentMethods.h"

//#import "LCRongCloud.h"

@implementation LCAppWebViewController (JS)
- (void)addScriptMessageHandler;
{
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"AppJS2OC"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"AppJS2OC_Base"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"AppJS2OC_Third"];
}

/*! @abstract Invoked when a script message is received from a webpage.
 delegate method.
 @param message The script message received.
 */
- (void)didReceiveScriptMessage:(WKScriptMessage *)message;
{
    if ([message.name isEqualToString:@"AppJS2OC"]) {
        [self AppJS2OCWithDict:message.body];
        
    } else if ([message.name isEqualToString:@"AppJS2OC_Base"]) {
        [self AppJS2OC_BaseWithDict:message.body];
        
    } else if ([message.name isEqualToString:@"AppJS2OC_Third"]) {
        [self AppJS2OC_ThirdWithDict:message.body];
        
    }
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
{
    [self didReceiveScriptMessage:message];
}

- (void)AppJS2OCWithDict:(NSDictionary *)dict{
    if([dict[@"type"] isEqualToString:@"Base"]){
        [self AppJS2OC_BaseWithDict:dict];
    }else if ([dict[@"type"] isEqualToString:@"Third"]){
        [self AppJS2OC_ThirdWithDict:dict];
    }
}

- (void)AppJS2OC_BaseWithDict:(NSDictionary *)dict{
    LCJS2OCBaseModel *model = [LCJS2OCBaseModel modelWithType:LCJS2OCModelTypeBase withDictionary:dict withViewController:self];
    
    switch (model.actionType) {
        case LCJS2OCBaseModelActionTypeFinish:
        {
            LCJS2OCBaseFinishModel *finish = model.model;
            
            if (finish.index.integerValue == 0){
                //刷新界面
                [self.webView reload];
                
            }else if (finish.index.integerValue > 0) {
                //跳转到前一个
                [self popViewControllerWithNumber:finish.index.integerValue + 1 refresh:finish.refresh.boolValue];
                
            }else if (finish.index.integerValue <= -1 && finish.index.integerValue >= -5){
                //返回首页
                [[NSNotificationCenter defaultCenter]postNotificationName:LCJS2OCFinishNotification object:self userInfo:@{@"index":@(-finish.index.integerValue - 1)}];
            }
            
            
        }
            break;
            
        case LCJS2OCBaseModelActionTypeImageBrowser:
        {
            [LCJS2OCBaseImageBrowserModel show:model];
            
        }
            break;
            
        case LCJS2OCBaseModelActionTypeSetNav:
        {
            [LCJS2OCBaseSetNavModel setNavWithModel:model];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)AppJS2OC_ThirdWithDict:(NSDictionary *)dict{
    LCJS2OCThirdModel *model = [LCJS2OCThirdModel modelWithType:LCJS2OCModelTypeThird withDictionary:dict withViewController:self];
    switch (model.thirdType) {
        case LCJS2OCThirdModelTypeWechat:
            
            [LCJS2OCThirdWechatModel wechatWithModel:model withBlock:^(BOOL success, LCJS2OCThirdModelActionType type, id object) {
                
            }];
            
            break;
            
        case LCJS2OCThirdModelTypeAli:
            [LCJS2OCThirdAliModel aliWithModel:model withBlock:^(BOOL success, LCJS2OCThirdModelActionType type, id object) {
                
            }];
            
            
            break;
        case LCJS2OCThirdModelTypeQQ:
            [LCJS2OCThirdQQModel qqWithModel:model withBlock:^(BOOL success, LCJS2OCThirdModelActionType type, id object) {
                
            }];
            
            break;
        case LCJS2OCThirdModelTypeNone:
            [LCJS2OCThirdShareModel shareWithModel:model withBlock:^(BOOL success) {
                
            }];
            
            break;
            
        default:
            break;
    }
    
    
    
}

/**
 跳转数量
 
 @param number 第几个
 @param refresh 是否刷新
 
 */
- (void)popViewControllerWithNumber:(NSInteger)number refresh:(BOOL)refresh{
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count >= number) {
        LCAppWebViewController *webVieController = (LCAppWebViewController *)viewControllers[viewControllers.count - number];
        if (refresh) {
            webVieController.refresh = YES;
            [webVieController.webView reload];
        }
        [self.navigationController popToViewController:webVieController animated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
