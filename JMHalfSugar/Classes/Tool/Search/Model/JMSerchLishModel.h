//
//  JMSerchLishModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMSerchLishModel : NSObject
/*
 *  分类id
 */
@property (nonatomic, copy) NSString *categoryID;
/*
 *  分类 名称
 */
@property (nonatomic, copy) NSString *name;
/*
 *  imageURL
 */
@property (nonatomic, copy) NSString *iconUrl;
/*
 *  english name
 */
@property (nonatomic, copy) NSString *en_name;
/*
 *  //  广场 viewController 中可能会用到
 */
@property (nonatomic, copy) NSString *sub_title;
+ (instancetype)searchListModelWithDictionary:(NSDictionary *)dictionary;
@end
