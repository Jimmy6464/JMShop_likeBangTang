//
//  JMSearchSingleGoodsModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMListDetailProductModel.h"
@class JMAuthor;
@interface JMSearchSingleGoodsModel : JMListDetailProductModel
/*
 *  imageUrl
 */
@property (nonatomic, copy) NSString *imageUrl;
/*
 *  author
 */
@property (nonatomic, strong) JMAuthor *author;
+ (instancetype)searchSingleGoodsWithDictionary:(NSDictionary *)dictionary;
@end
