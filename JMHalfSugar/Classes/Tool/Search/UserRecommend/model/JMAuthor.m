//
//  JMAuthor.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMAuthor.h"

@implementation JMAuthor
+ (instancetype)authorWithDictionary:(NSDictionary *)dict
{
    JMAuthor *author = [JMAuthor new];
    [author setValuesForKeysWithDictionary:dict];
    return author;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}
@end
