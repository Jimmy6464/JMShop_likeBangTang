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
    if ([key isEqualToString:@"pic"] && [value isKindOfClass:[NSArray class]]) {
        NSArray *pics = value;
        NSMutableArray *pictures = [ NSMutableArray array];
        [pics enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMPictureModel *model = [JMPictureModel new];
            model.imageUrl = obj[@"pic"];
            model.im_width = [obj[@"width"] floatValue];
            model.im_height = [obj[@"height"] floatValue];
            [pictures addObject:model];
        }];
        _picArray = pictures;
    }

    if ([key isEqualToString:@"user"]) {
        NSLog(@"%@",value);
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
