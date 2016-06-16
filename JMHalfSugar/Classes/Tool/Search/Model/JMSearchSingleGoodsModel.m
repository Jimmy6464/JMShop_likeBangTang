//
//  JMSearchSingleGoodsModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchSingleGoodsModel.h"
#import "JMAuthor.h"
@implementation JMSearchSingleGoodsModel
+ (instancetype)searchSingleGoodsWithDictionary:(NSDictionary *)dictionary
{
    JMSearchSingleGoodsModel *model = [JMSearchSingleGoodsModel new];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"pic"]) {
        _imageUrl = value;
    }
    if ([key isEqualToString:@"user"]) {
        [_author setValuesForKeysWithDictionary:value];
    }
    NSLog(@"yes");
}
@end
