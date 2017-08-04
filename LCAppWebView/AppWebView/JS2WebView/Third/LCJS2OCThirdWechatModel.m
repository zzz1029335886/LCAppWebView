//
//  LCJS2OCWechat.m
//  kryb
//
//  Created by 凌创科技 on 2017/7/18.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCThirdWechatModel.h"
//#import "LCWeChat.h"

@interface LCJS2OCThirdWechatModel()

@end

@implementation LCJS2OCThirdWechatModel
+ (void)wechatModel:(LCJS2OCThirdModel *)model;
{
    
}

+ (void)wechatWithModel:(LCJS2OCThirdModel *)model withBlock:(void(^)(BOOL success,LCJS2OCThirdModelActionType type,id object))block;
{
    LCJS2OCThirdWechatModel *wechatModel = model.model;

    if(model.actionType == LCJS2OCThirdModelActionTypePay){
//        [LCWeChatPay weChatPayWithDict:wechatModel.payParams withCompleteBlock:^(BOOL success) {
//            if(block){
//                block(success,model.actionType,nil);
//            };
//        }];
    }else if (model.actionType == LCJS2OCThirdModelActionTypeShare){
//        NSDictionary *shareParams = wechatModel.shareParams;

        //[shareParams[@"scene"] intValue] urlStr:shareParams[@"url"] imageUrlStr:shareParams[@"imgUrl"] title:shareParams[@"title"] text:shareParams[@"text"]
//        [LCWeChatShare shareWithScene:[shareParams[@"scene"] intValue] imageUrl:shareParams[@"imgUrl"] title:shareParams[@"title"] text:shareParams[@"text"] URL:shareParams[@"url"] withCompleteBlock:^(BOOL success) {
//            if(block){
//                block(success,model.actionType,nil);
//            }
//        }];
    }else if (model.actionType == LCJS2OCThirdModelActionTypeLogin){
//        [LCWeChatLogin weChatLoginWithViewController:model.controller withSuccessBlock:^(BOOL success, NSString *code) {
//            if(block){
//                block(success,model.actionType,code);
//            }
//        }];
        
    }
    
    
    
}

@end
