//
//  JMPorductDetailTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPorductDetailTool.h"
#import "JMProductDetailModel.h"
#import "JMCommentModel.h"
@implementation JMPorductDetailTool

+(JMProductDetailModel *)createProductDetailModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stylenand 打底霜" ofType:nil];
    NSData *JSONData = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *dataDict = dict[@"data"];
    NSDictionary *dataProduct = dict[@"data"][@"product"];
    JMProductDetailModel *model = [JMProductDetailModel productDetailModelWithDictionary:dataDict];
    [model setValuesForKeysWithDictionary:dataProduct];
    return model;
}
+ (NSMutableArray  *)createCommentList:(NSArray *)commentData
{
    NSMutableArray *commentArray = [NSMutableArray new];
    if (commentData.count>0) {
        [commentData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMCommentModel *model = [JMCommentModel commentWithDictionary:obj]
            ;
            [commentArray addObject:model];
        }];
    }else {
        return nil;
    }
    return commentArray;
}
@end
