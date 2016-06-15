//
//  JMUserRecommendModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMUserRecommendModel.h"
#import "JMUserRecommendDynamicModel.h"
#import "JMUserRecommendPicModel.h"
#import "JMUserRecommendTagsModel.h"
#import "JMUserRecommendProductModel.h"
#import "JMAuthor.h"
@implementation JMUserRecommendModel
+ (instancetype)userRecommendWithDictionary:(NSDictionary *)dict
{
    JMUserRecommendModel *model = [JMUserRecommendModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _userRecommendID = value;
    }
    if ([key isEqualToString:@"dateStr"]) {
        _createTime = value;
    }
    if ([key isEqualToString:@"author"]) {
        [_author setValuesForKeysWithDictionary:value];
    }
    if ([key isEqualToString:@"pics"]) {
        NSArray *array = value;
        NSMutableArray *pics = [NSMutableArray new];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMUserRecommendProductModel *model = [JMUserRecommendProductModel userRecommendProductWithDictionary:obj];
            [pics addObject:model];
        }];
        _picArray = pics;
    }
    if ([key isEqualToString:@"dynamic"]) {
        [_dynamic setValuesForKeysWithDictionary:value];
    }
    
}
@end
