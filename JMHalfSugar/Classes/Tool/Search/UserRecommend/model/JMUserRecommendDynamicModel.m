//
//  JMUserRecommendDynamicModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMUserRecommendDynamicModel.h"

@implementation JMUserRecommendDynamicModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"yes");
}
+ (instancetype)userRecommentDynamicWithDictionary:(NSDictionary *)dict
{
    JMUserRecommendDynamicModel *model = [JMUserRecommendDynamicModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
