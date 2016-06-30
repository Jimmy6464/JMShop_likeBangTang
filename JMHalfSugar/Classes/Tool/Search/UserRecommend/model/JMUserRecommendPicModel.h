//
//  JMUserRecommendPicModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *  用户推荐中的商品model
 */
@interface JMUserRecommendPicModel : NSObject
/*
 *  imageUrl
 */
@property (nonatomic, copy) NSString *url;
/*
 *  width
 */
@property (nonatomic, assign) CGFloat width;
/*
 *  height
 */
@property (nonatomic, assign) CGFloat height;
/*
 *  the sign of image
 */
@property (nonatomic, copy) NSString *tags;
@property (nonatomic ,strong) NSDictionary *tagDict;

+ (instancetype)userRecommendPicWithDictionary:(NSDictionary *)dict;

@end
