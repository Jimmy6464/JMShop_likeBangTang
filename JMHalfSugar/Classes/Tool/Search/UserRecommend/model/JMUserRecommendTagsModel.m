//
//  JMUserRecommendTagsModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMUserRecommendTagsModel.h"

@implementation JMUserRecommendTagsModel
+ (instancetype)userRecommendTagsWithDcitionary:(NSDictionary *)dict
{
    JMUserRecommendTagsModel *model = [JMUserRecommendTagsModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}
@end
