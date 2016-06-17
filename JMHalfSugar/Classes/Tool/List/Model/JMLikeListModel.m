//
//  JMLikeListModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMLikeListModel.h"

@implementation JMLikeListModel
+ (instancetype)likeListModelWithDictionary:(NSDictionary *)dict
{
    JMLikeListModel *model = [JMLikeListModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"user_id"]) {
        _userID = value;
    }
    if ([key isEqualToString:@"avatar"]) {
        _headerImageUrl = value;
    }
    NSLog(@"--------Like list 's undefined key is %@",key);
}
@end
