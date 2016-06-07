//
//  JMProductRecommendModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/6.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductRecommendModel.h"

@implementation JMProductRecommendModel
+ (instancetype)productRecommendWithDictionary:(NSDictionary *)dict
{
    JMProductRecommendModel *model = [JMProductRecommendModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine:%@",key);
}
@end
