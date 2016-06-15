//
//  JMListDetailProductModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailProductModel.h"
#import "JMPictureModel.h"
#import "JMLikeListModel.h"
@implementation JMListDetailProductModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _productID = value;
    }
    if ([key isEqualToString:@"title"]) {
        _productName = value;
    }
    if ([key isEqualToString:@"desc"]) {
        _detailText = value;
    }
    if ([key isEqualToString:@"likes"]) {
        _likeNumbers = value;
    }
    if ([key isEqualToString:@"pic"]) {
        NSArray *pics = value;
        NSMutableArray *pictures = [ NSMutableArray array];
        [pics enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMPictureModel *model = [JMPictureModel new];
            model.imageUrl = obj[@"p"];
            model.im_width = [obj[@"w"] floatValue];
            model.im_height = [obj[@"h"] floatValue];
            [pictures addObject:model];
        }];
        _picArray = pictures;
    }
    if ([key isEqualToString:@"likes_list"]) {
        NSArray *likes = value;
        NSMutableArray *likesList = [ NSMutableArray array];
        [likes enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMLikeListModel *model = [JMLikeListModel new];
            model.headerImageUrl = obj[@"a"];
            model.userID = obj[@"u"];
            [likesList addObject:model];
        }];
        _likes_list = likesList;
    }
    NSLog(@"*****************the undefined key is %@",key);
}
+ (instancetype)listDeatilProductWithDictionary:(NSDictionary *)dict
{
    JMListDetailProductModel *model = [JMListDetailProductModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
