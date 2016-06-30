//
//  JMPlantGrassTeamModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/29.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMPlantGrassTeamModel : NSObject
@property (nonatomic, copy) NSString *teamID;
/*
 *  teamName
 */
@property (nonatomic, copy) NSString *teamName;
/*
 *  pic
 */
@property (nonatomic, copy) NSString *pic1;
/*
 *  pic
 */
@property (nonatomic, copy) NSString *pic2;
/*
 *  pic
 */
@property (nonatomic, copy) NSString *pic3;
/*
 *  浏览次数
 */
@property (nonatomic, assign) NSInteger lookCount;
/*
 *  喜欢次数
 */
@property (nonatomic, assign) NSInteger likeCount;
/*
 *  帖子数量
 */
@property (nonatomic, assign) NSInteger postsCount;
/*
 *  详情描述
 */
@property (nonatomic, copy) NSString *teamDetail;
+ (instancetype)plantGrassTeamWithDictionary:(NSDictionary *)dict;
@end
