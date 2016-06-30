//
//  JMSquareModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/29.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMSquareModel : NSObject
@property (nonatomic, strong) NSString *squareID;
/*
 *  title
 */
@property (nonatomic, copy) NSString *title;
/*
 *  二级分类
 */
@property (nonatomic, strong) NSArray *elements;
+ (instancetype)squareModelWithDictionary:(NSDictionary *)dict;
@end
