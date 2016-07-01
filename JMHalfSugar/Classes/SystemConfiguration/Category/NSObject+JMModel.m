//
//  NSObject+JMModel.m
//  EasyPay_HD
//
//  Created by Jimmy on 16/5/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "NSObject+JMModel.h"
#import <objc/message.h>
@implementation NSObject (JMModel)
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    id objc = [[self alloc]init];
    
    unsigned int count = 0;
    
    //copy self'propertList
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        //get one of the self'property at index
        Ivar ivar = ivarList[i];
        //get property Type(such as "NSString","NSArray" and so on)
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        //get property Name
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //trim '_' of propertyName
        NSString *key = [propertyName substringFromIndex:1];
        
        //get value from dict
        id value = dict[key];
        
        if (value) {
            //in KVC,can not spread the nil value
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}
+ (NSDictionary *)removeEmptyFromDict:(NSDictionary *)dict
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSMutableArray *keys = [NSMutableArray new];
    [mDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNull class]]) {
            [keys addObject:key];
        }
    }];
    [mDict removeObjectsForKeys:keys];
    return [NSDictionary dictionaryWithDictionary: mDict];
}
- (id)changeNullObject:(id)sender placeholder:(NSString *)placeholder
{
    if (sender == nil) {
        sender = placeholder;
    }
    return sender;
}
@end
