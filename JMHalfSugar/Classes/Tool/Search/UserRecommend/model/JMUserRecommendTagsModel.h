//
//  JMUserRecommendTagsModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMUserRecommendTagsModel : NSObject
/*
 *  tag id
 */
@property (nonatomic, copy) NSString *ID;
/*
 *  name
 */
@property (nonatomic, copy) NSString *name;
+ (instancetype)userRecommendTagsWithDcitionary:(NSDictionary *)dict;
@end
