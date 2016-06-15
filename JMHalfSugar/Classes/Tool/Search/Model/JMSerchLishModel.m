//
//  JMSerchLishModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSerchLishModel.h"

@implementation JMSerchLishModel
+ (instancetype)searchListModelWithDictionary:(NSDictionary *)dictionary
{
    JMSerchLishModel *model = [JMSerchLishModel new];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _categoryID = value;
    }
    if ([key isEqualToString:@"icon"]) {
        _iconUrl = value;
    }
    NSLog(@"SearchModel undefined key:%@",key);
}
@end
