//
//  JMCommentModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMCommentModel.h"

@implementation JMCommentModel
+ (instancetype)commentWithDictionary:(NSDictionary *)dict
{
    JMCommentModel *model = [[JMCommentModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefined key: %@",key);
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    if ([key isEqualToString:@"username"]) {
        _nickname = value;
    }
    if ([key isEqualToString:@"avatar"]) {
        _headerImageURL = value;
    }
    
    if ([key isEqualToString:@"datastr"]) {
        _createTime = value;
    }
    if ([key isEqualToString:@"praise"]) {
        _praiseCount = value;
    }
    if ([key isEqualToString:@"at_user"]) {
        NSDictionary *userDict = value;
        if (userDict.count != 0) {
            _isReplyed = YES;
        }
    }

}
@end
