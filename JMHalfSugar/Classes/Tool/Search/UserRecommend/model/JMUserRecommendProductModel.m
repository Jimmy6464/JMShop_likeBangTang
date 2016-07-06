//
//  JMUserRecommendProductModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMUserRecommendProductModel.h"

@implementation JMUserRecommendProductModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"pic"]) {
        _picUrl = value ;
    }
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

+ (instancetype)userRecommendProductWithDictionary:(NSDictionary *)dict
{
    JMUserRecommendProductModel *model = [JMUserRecommendProductModel new];
    model.isCollect = NO;
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
