//
//  JMDailyBannerModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMDailyBannerModel.h"

@implementation JMDailyBannerModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.bannerID = value;
    }
    
    NSLog(@"UndefinedKey:%@",key);
}
+ (instancetype)dailyBannerModelWithDictionary:(NSDictionary *)dict
{
    JMDailyBannerModel *model = [JMDailyBannerModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
