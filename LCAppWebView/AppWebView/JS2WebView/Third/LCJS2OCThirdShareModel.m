//
//  LCJS2OCThirdShareModel.m
//  kryb
//
//  Created by 凌创科技 on 2017/7/19.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCThirdShareModel.h"
#import "LCAppShareView.h"
//#import "LCWeChatShare.h"
//#import "LCTencentShare.h"

@implementation LCJS2OCThirdShareModel
+ (void)shareWithModel:(LCJS2OCThirdModel *)model withBlock:(void(^)(BOOL success))block;
{
//    [LCAppShareView showShareViewWithCompleteBlock:^(LCShareViewType type) {
//        NSDictionary *shareParams = [model.model shareParams];
//        NSString *imgUrl = shareParams[@"imgUrl"];
//        NSString *title = shareParams[@"title"];
//        NSString *text = shareParams[@"text"];
//        NSString *url = shareParams[@"url"];
//        
//        if (type == LCShareViewTypeWeChatZone) {
//            [LCWeChatShare shareWithScene:WXSceneTypeTimeline imageUrl:imgUrl title:title text:text URL:url withCompleteBlock:^(BOOL success) {
//                if(block){
//                    block(success);
//                }
//            }];
//        } else if (type == LCShareViewTypeWeChatFriend){
//            [LCWeChatShare shareWithScene:WXSceneTypeSession imageUrl:imgUrl title:title text:text URL:url withCompleteBlock:^(BOOL success) {
//                if(block){
//                    block(success);
//                }
//            }];
//        } else if (type == LCShareViewTypeWeChatFavorite){
//            [LCWeChatShare shareWithScene:WXSceneTypeFavorite imageUrl:imgUrl title:title text:text URL:url withCompleteBlock:^(BOOL success) {
//                if(block){
//                    block(success);
//                }
//            }];
//        } else if (type == LCShareViewTypeQQZone){
//            [LCTencentShare shareScene:LCTencentShareZone urlStr:url imageUrlStr:imgUrl title:title text:text completeBlock:^(BOOL success) {
//                
//                if(block){
//                    block(success);
//                }
//                
//            }];
//        } else if (type == LCShareViewTypeQQFriend){
//            [LCTencentShare shareScene:LCTencentShareFriend urlStr:url imageUrlStr:imgUrl title:title text:text completeBlock:^(BOOL success) {
//                
//                if(block){
//                    block(success);
//                }
//                
//            }];
//        }
//        
//    }];
}

@end
