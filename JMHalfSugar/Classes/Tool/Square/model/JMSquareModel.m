//
//  JMSquareModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/29.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSquareModel.h"
#import "JMSerchLishModel.h"
@implementation JMSquareModel
+ (instancetype)squareModelWithDictionary:(NSDictionary *)dict
{
    JMSquareModel *model = [JMSquareModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _squareID = value;
    }

}
- (void)setElements:(NSArray *)elements
{
   
    NSMutableArray *elementList = [NSMutableArray new];
    if (elements.count>0) {
        [elements enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMSerchLishModel *searchList = [JMSerchLishModel searchListModelWithDictionary:obj];
            [elementList addObject:searchList];
        }];
        _elements = elementList;
    }else {
        _elements = elements;
    }
    
}
@end
