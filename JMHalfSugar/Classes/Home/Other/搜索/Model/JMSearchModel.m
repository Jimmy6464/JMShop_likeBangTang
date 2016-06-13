//
//  JMSearchModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchModel.h"

@implementation JMSearchModel
+ (instancetype)searchModelWithDictionary:(NSDictionary *)dict
{
    JMSearchModel *model = [JMSearchModel new];
    [model setValuesForKeysWithDictionary:dict];
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
    if ([key isEqualToString:@"subclass"]) {
        NSArray *array = value;
        self.subList = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMSearchModel *model = [JMSearchModel searchModelWithDictionary:obj];
            [self.subList addObject:model];
        }];
    }
    NSLog(@"SearchModel undefined key:%@",key);
}
@end
