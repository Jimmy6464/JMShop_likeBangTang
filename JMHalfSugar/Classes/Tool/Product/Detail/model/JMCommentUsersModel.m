//
//  JMCommentUsersModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMCommentUsersModel.h"

@implementation JMCommentUsersModel
+ (instancetype)commentUserWithDictionary:(NSDictionary *)dict
{
    JMCommentUsersModel *user = [JMCommentUsersModel new];
    [user setValuesForKeysWithDictionary:dict];
    return user;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"avatar"]) {
        _imageUrl = value;
    }
    NSLog(@"undefined key is %@",key);
}
@end
