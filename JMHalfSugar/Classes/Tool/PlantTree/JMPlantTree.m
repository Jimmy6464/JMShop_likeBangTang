//
//  JMPlantTree.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/29.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPlantTree.h"
#import "JMPlantGrassTeamModel.h"
@implementation JMPlantTree
+ (NSArray *)readTeamData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"种草小分队" ofType:nil];
    NSData *JSONData = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *dataDict = [dict objectForKey:@"data"];
    NSArray *dataArray = [dataDict objectForKey:@"list"];
    NSMutableArray *teamArray = [NSMutableArray new];
    for (NSInteger i = 0; i<dataArray.count; i++) {
        NSDictionary *moDict = dataArray[i];
        JMPlantGrassTeamModel *model = [JMPlantGrassTeamModel plantGrassTeamWithDictionary:moDict];
        [teamArray addObject:model];
    }
    return teamArray;
}
@end
