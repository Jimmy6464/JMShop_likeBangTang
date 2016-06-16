//
//  JMProductDetailModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductDetailModel.h"
#import "JMCommentModel.h"
#import "JMCommentUsersModel.h"
@implementation JMProductDetailModel
+ (instancetype)productDetailModelWithDictionary:(NSDictionary *)dict
{
    JMProductDetailModel *model =[ JMProductDetailModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"share_url"]) {
        _share_URL = value;
    }
    if ([key isEqualToString:@"comment_list"]) {
        NSArray *array = value;
        NSMutableArray *comments = [NSMutableArray new];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMCommentModel *comment = [JMCommentModel commentWithDictionary:obj];
            [comments addObject:comment];
        }];
        _comment_list = comments;
        
        
    }
    
    if ([key isEqualToString:@"likes_list"]) {
        NSArray *array = value;
        NSMutableArray *commentusers = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMCommentUsersModel *user = [JMCommentUsersModel commentUserWithDictionary:obj];
            [commentusers addObject:user];
        }];
        _likeUser = commentusers;
    }
}
@end
