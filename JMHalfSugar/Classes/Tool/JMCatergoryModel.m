//
//  JMCatergoryModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/7.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMCatergoryModel.h"

@implementation JMCatergoryModel
+ (instancetype)categroyWithDictionary:(NSDictionary *)dict
{
    JMCatergoryModel *catergory = [JMCatergoryModel new];
    [catergory setValuesForKeysWithDictionary:dict];
    return catergory;
}
@end
