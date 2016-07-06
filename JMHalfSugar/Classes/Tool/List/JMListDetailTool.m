//
//  JMListDetailTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailTool.h"
#import "JMListModel.h"
#define ListJSONName @[@"1872",@"1898"]
@implementation JMListDetailTool
+ (JMListModel *)createListModelWithListID:(NSString *)listID
{
    NSDictionary *dict = [[self class] readDataFromJSONWithFileName:listID];
    if (!dict) {
        return nil;
    }
    NSDictionary *dataDict = dict[@"data"];
    JMListModel *model = [JMListModel listModelWithDictionary:dataDict andListID:listID];
    return model;
}
+ (NSDictionary *)readDataFromJSONWithFileName:(NSString *)fileName;
{
    BOOL isExist = NO;
    for (NSString *name in ListJSONName) {
        if ([name isEqualToString:fileName]) {
            isExist = YES;
        }
    }
    if (!isExist) {
        return nil;
    }else {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        return dict;
    }
    return nil;
}
@end
