//
//  JMUserRecommendDynamicModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMUserRecommendDynamicModel : NSObject
/*
 *  浏览次数
 */
@property (nonatomic, copy) NSString *views;
/*
 *  评论次数
 */
@property (nonatomic, copy) NSString *comments;
/*
 *  喜欢人数
 */
@property (nonatomic, copy) NSString *likes;
/*
 *  是否收藏
 */
@property (nonatomic, assign) BOOL isCollect;
/*
 *  是否评论
 */
@property (nonatomic, assign) BOOL is_comment;
+ (instancetype)userRecommentDynamicWithDictionary:(NSDictionary *)dict;
@end
