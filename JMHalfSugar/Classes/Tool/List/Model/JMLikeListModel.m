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
    if ([key isEqualToString:@"user_id"] || [key isEqualToString:@"u"]) {
        _userID = value;
    }
    if ([key isEqualToString:@"avatar"] || [key isEqualToString:@"a"]) {
        _headerImageUrl = [NSString stringWithFormat:@"http://7te7t9.com2.z0.glb.qiniucdn.com/\%@",value];
    }
    NSLog(@"--------Like list 's undefined key is %@",key);
}
@end
