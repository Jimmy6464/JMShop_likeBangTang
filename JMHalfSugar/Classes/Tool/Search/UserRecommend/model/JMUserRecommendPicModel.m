//
//  JMUserRecommendPicModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMUserRecommendPicModel.h"

@implementation JMUserRecommendPicModel
+ (instancetype)userRecommendPicWithDictionary:(NSDictionary *)dict
{
    JMUserRecommendPicModel *model = [JMUserRecommendPicModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setWidth:(CGFloat)width
{
    if (width == 900) {
        _width = JMDeviceWidth;
    }else {
        _width = width;
    }
}
- (void)setHeight:(CGFloat)height
{
    if (_height == 900) {
        _height = JMDeviceWidth;
    }else {
        _height = height;
    }
}
- (void)setTag:(NSString *)tag
{
    _tag = tag;
    if (_tag) {
        NSData *stringData = [_tag dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *dictArr = [NSJSONSerialization JSONObjectWithData:stringData options:NSJSONReadingAllowFragments error:nil];
        _tagDict = dictArr[0];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"yes");
}
@end
