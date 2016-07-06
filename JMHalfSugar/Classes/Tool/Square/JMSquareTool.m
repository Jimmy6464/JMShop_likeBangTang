//
//  JMSquareTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/29.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSquareTool.h"
#import "JMSquareModel.h"
@implementation JMSquareTool
+ (NSArray *)createSearchListModel
{
    NSMutableArray *searchList = [NSMutableArray new];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"广场" ofType:nil];
    NSData *JSONData = [NSData dataWithContentsOfFile:path];
    NSDictionary *JSONDict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *dataDict = [JSONDict objectForKey:@"data"];
    NSArray *moduleData = dataDict[@"module_elements"];
    if (moduleData.count>0) {
        [moduleData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMSquareModel *model = [JMSquareModel squareModelWithDictionary:obj];
            [searchList addObject:model];
        }];
    }
    return searchList;
}
@end
