//
//  LCJS2OCCommonUploadImageModel.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/20.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCCommonUploadImageModel.h"
#import <Photos/Photos.h>
#import "LCImagePickerViewController.h"

@interface LCJS2OCCommonUploadImageModel()
@property (nonatomic,copy)UploadImageBlock uploadImageBlock;
@property (nonatomic,strong)UIViewController *controller;

@end

@implementation LCJS2OCCommonUploadImageModel

- (NSInteger)count{
    if(_count == 0){
        return 1;
    }
    return _count;
}

+ (void)uploadImageWithModel:(LCJS2OCModel *)commonModel withCompleteBlock:(UploadImageBlock)uploadImageBlock;
{
    LCJS2OCCommonUploadImageModel *model = commonModel.model;
    model.uploadImageBlock = uploadImageBlock;
    model.controller = commonModel.controller;
    [model start];
    
}

- (void)start{
    
//    LCImagePickerViewController *imagePickerViewController = nil;
//    __block typeof(imagePickerViewController) blockImagePickerViewController = imagePickerViewController;

    [LCImagePickerViewController showWithController:self.controller completeBlock:^(BOOL success, LCImagePickerViewController *controller) {
        if(controller){
            ZZZBlackStatusBar
            controller.title = [NSString stringWithFormat:@"选择  %@",self.title];
            controller.didFinishPickingImage = ^(UIImage *image) {
                [LCHTTPTool uploadImage:image success:^(LCHTTPResult *result) {
                    if(self.uploadImageBlock){
                        self.uploadImageBlock(result.code == 1, result.resp[@"fileIds"]);
                    }
                } failure:^(NSError *error) {
                    self.uploadImageBlock(NO,nil);
                }];
            };
            [self.controller presentViewController:controller animated:YES completion:nil];
        }
        
    }];
    
}

@end
