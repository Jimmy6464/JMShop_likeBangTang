//
//  JMListModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListModel.h"
#import "JMListDetailProductModel.h"
@implementation JMListModel
+ (instancetype)listModelWithDictionary:(NSDictionary *)dict andListID:(NSString *)listID
{
    JMListModel *model = [JMListModel new];
    model.listID = listID;
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"desc"]) {
        _detailText = value;
    }
    if ([key isEqualToString:@"pic"]) {
        _imageUrl = value;
    }
    if ([key isEqualToString:@"likes"]) {
        _likesNum = value;
    }
    if ([key isEqualToString:@"share_pic"]) {
        _share_imageURL = value;
    }
    if ([key isEqualToString:@"product_pic_host"]) {
        _imageHost = value;
    }
    if ([key isEqualToString:@"product"]) {
        NSArray *array = value;
        NSMutableArray *products = [NSMutableArray new];
        [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMListDetailProductModel *model = [JMListDetailProductModel listDeatilProductWithDictionary:obj];
            [products addObject:model];
        }];
        _prouctArray = products;
    }
}
@end
