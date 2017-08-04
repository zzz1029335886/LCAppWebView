//
//  LCJS2OCModel.m
//  kryb
//
//  Created by 凌创科技 on 2017/6/4.
//  Copyright © 2017年 凌创科技. All rights reserved.
//

#import "LCJS2OCModel.h"

@implementation LCJS2OCModel

- (instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        _controller = (LCAppWebViewController *)controller;
        
    }
    return self;
}
- (void)setController:(LCAppWebViewController *)controller;
{
    _controller = controller;
}

+ (instancetype)modelWithType:(LCJS2OCModelType)type withDictionary:(NSDictionary *)dict withViewController:(UIViewController *)controller;
{
    NSString *action = dict[@"action"];
    NSString *classString;
    NSString *modelClassString;
    NSMutableDictionary *mutableDictionary;

    switch (type) {
        case LCJS2OCModelTypeBase:
            classString = @"LCJS2OCBaseModel";
            modelClassString = [NSString stringWithFormat:@"LCJS2OCBase%@Model",action];
            
            break;
        case LCJS2OCModelTypeCommon:
            classString = @"LCJS2OCCommonModel";
            modelClassString = [NSString stringWithFormat:@"LCJS2OCCommon%@Model",action];
            
            break;
        case LCJS2OCModelTypeThird:
            classString = @"LCJS2OCThirdModel";
            if(!dict[@"thirdName"]){
                mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
                [mutableDictionary setValue:mutableDictionary[@"model"][@"thirdName"] forKey:@"thirdName"];
                dict = mutableDictionary;
            }
            
            modelClassString = [NSString stringWithFormat:@"LCJS2OCThird%@Model",dict[@"thirdName"]];
            break;
            
        case LCJS2OCModelTypeKryb:
            classString = @"LCJS2OCKrybModel";
            modelClassString = [NSString stringWithFormat:@"LCJS2OCKryb%@Model",action];
            
            break;
            
        default:
            break;
    }
    
    Class aClass = NSClassFromString(classString);
    Class modelClass = NSClassFromString(modelClassString);
    
    LCJS2OCModel *model = [aClass mj_objectWithKeyValues:dict];
    model.controller = (LCAppWebViewController *)controller;
    model.action = action;
    model.model = [modelClass mj_objectWithKeyValues:dict[@"model"]];
    model.type = type;
    
    return model;
}

+ (instancetype)modelWithType:(LCJS2OCModelType)type withDictionary:(NSDictionary *)dict;
{
    return [self modelWithType:type withDictionary:dict withViewController:nil];
}

@end
