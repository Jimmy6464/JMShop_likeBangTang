//
//  NSObject+JMModel.h
//  EasyPay_HD
//
//  Created by Jimmy on 16/5/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JMModel)
+ (instancetype)modelWithDict:(NSDictionary *)dict;
+ (NSDictionary *)removeEmptyFromDict:(NSDictionary *)dict;
- (id)changeNullObject:(id)sender placeholder:(NSString *)placeholder;
@end
