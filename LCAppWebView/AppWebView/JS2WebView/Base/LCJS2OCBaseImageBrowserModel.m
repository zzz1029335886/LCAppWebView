//
//  LCJS2OCBaseImageBrowserModel.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/5.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCBaseImageBrowserModel.h"
#import <IDMPhotoBrowser/IDMPhotoBrowser.h>
@interface LCJS2OCBaseImageBrowserModel()<IDMPhotoBrowserDelegate>
@property (nonatomic,strong)UIViewController *controller;

@end

@implementation LCJS2OCBaseImageBrowserModel
+ (void)show:(LCJS2OCModel *)model;
{
    LCJS2OCBaseImageBrowserModel *imageBrowser = model.model;
    imageBrowser.controller = model.controller;
    NSArray *urlStrings = imageBrowser.urls;
    
    if(!urlStrings.count){
        return;
    }
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:urlStrings.count];
    
    for (NSString *urlString in urlStrings) {
        NSURL *url = [NSURL URLWithString:urlString];
        IDMPhoto *photo = [IDMPhoto photoWithURL:url];
        [photos addObject:photo];
    }
    
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
//    browser.delegate = imageBrowser;
    [browser setInitialPageIndex:imageBrowser.currentIndex];
    [model.controller presentViewController:browser animated:YES completion:nil];
}

- (void)willDisappearPhotoBrowser:(IDMPhotoBrowser *)photoBrowser{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.controller resignFirstResponder];
        
    });
}

@end
