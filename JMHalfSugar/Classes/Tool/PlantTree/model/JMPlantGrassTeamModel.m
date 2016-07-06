//
//  JMPlantGrassTeamModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/29.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPlantGrassTeamModel.h"

@implementation JMPlantGrassTeamModel
+ (instancetype)plantGrassTeamWithDictionary:(NSDictionary *)dict
{
    JMPlantGrassTeamModel *model = [[JMPlantGrassTeamModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _teamID = value;
    }
    if ([key isEqualToString:@"name"]) {
        _teamName = value;
    }
    if ([key isEqualToString:@"desc"]) {
        _teamDetail = value;
    }
    if ([key isEqualToString:@"dynamic"]) {
        NSDictionary *dataDict = value;
        NSNumber *lookNum = [dataDict objectForKey:@"views"];
        NSNumber *likesNum = [dataDict objectForKey:@"attentions"];
        NSNumber *postsNum = [dataDict objectForKey:@"posts"];
        
        _lookCount = lookNum.integerValue;
        _likeCount = likesNum.integerValue;
        _postsCount = postsNum.integerValue;
    
    }
}
@end
