//
//  JMUserRecommendProductModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *  用户推荐的商品model
 */
@interface JMUserRecommendProductModel : NSObject
/*
 *  ID
 */
@property (nonatomic, copy) NSString *ID;
/*
 *  title
 */
@property (nonatomic, copy) NSString *title;
/*
 *  price
 */
@property (nonatomic, copy) NSString *price;
/*
 *  url
 */
@property (nonatomic, copy) NSString *url;
/*
 *  platform
 */
@property (nonatomic, copy) NSString *platform;
/*
 *  picURL
 */
@property (nonatomic, copy) NSString *picUrl;
/*
 *  isCollect
 */
@property (nonatomic, assign) BOOL isCollect;
+ (instancetype)userRecommendProductWithDictionary:(NSDictionary *)dict;
@end
