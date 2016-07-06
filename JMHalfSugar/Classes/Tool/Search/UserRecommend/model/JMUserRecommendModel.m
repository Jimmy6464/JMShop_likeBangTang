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
    if ([key isEqualToString:@"datestr"]) {
        _createTime = value;
    }
    if ([key isEqualToString:@"author"]) {
        [_author setValuesForKeysWithDictionary:value];
    }
    if ([key isEqualToString:@"pics"]) {
        NSArray *array = value;
        NSMutableArray *pics = [NSMutableArray new];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMUserRecommendPicModel *model = [JMUserRecommendPicModel userRecommendPicWithDictionary:obj];
            [pics addObject:model];
        }];
        _picArray = pics;
    }
    if ([key isEqualToString:@"dynamic"]) {
        [_dynamic setValuesForKeysWithDictionary:value];
    }
    
    if ([key isEqualToString:@"product"]) {
        NSMutableArray *productArray = [NSMutableArray new];
        NSArray *products = value;
        [products enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMUserRecommendProductModel *model = [JMUserRecommendProductModel userRecommendProductWithDictionary:obj];
            [productArray addObject:model];
        }];
        _productArray = productArray;
    }
    
    if ([key isEqualToString:@"tags"]) {
        NSMutableArray *tagsArray = [NSMutableArray new];
        NSArray *tags = value;
        [tags enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMUserRecommendTagsModel *model = [JMUserRecommendTagsModel userRecommendTagsWithDcitionary:obj];
            [tagsArray addObject:model];
        }];
        _tagArray = tagsArray;
    }
    
}
- (void)setAuthor:(JMAuthor *)author
{
    if ([author isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dcit = (NSDictionary *)author;
        _author =[JMAuthor authorWithDictionary:dcit];
    }else {
        _author = author;
    }
}
- (void)setDynamic:(JMUserRecommendDynamicModel *)dynamic
{
    if ([dynamic isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dcit = (NSDictionary *)dynamic;
        _dynamic = [JMUserRecommendDynamicModel userRecommentDynamicWithDictionary:dcit];
    }else {
        _dynamic = dynamic;
    }
}
@end
