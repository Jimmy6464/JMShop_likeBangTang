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
#import "JMLikeListModel.h"
@implementation JMProductDetailModel
+ (instancetype)productDetailModelWithDictionary:(NSDictionary *)dict
{
    JMProductDetailModel *model =[ JMProductDetailModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"++++%@+++",key);
    [super setValue:value forUndefinedKey:key];
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
- (void)setComment_list:(NSArray *)comment_list
{
    _comment_list = comment_list;
    if (comment_list) {
        NSMutableArray *array = [NSMutableArray new];
        [comment_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMCommentModel *model = [JMCommentModel commentWithDictionary:obj];
            [array addObject:model];
        }];
        _comment_list = array;
    }
}
- (void)setLikes_list:(NSArray<JMLikeListModel *> *)likes_list
{
    
    [super setLikes_list:likes_list];
    NSMutableArray *array = [NSMutableArray new];
    [likes_list enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JMLikeListModel *model = [JMLikeListModel likeListModelWithDictionary:obj];
        [array addObject:model];
    }];
    _likeUser = array;
    
}
@end
