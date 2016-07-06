//
//  JMLikeListModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMLikeListModel : NSObject
/*
 *  用户id
 */
@property (nonatomic, copy) NSString *userID;
/*
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;
/*
 *  用户头像URL
 */
@property (nonatomic, copy) NSString *headerImageUrl;
+ (instancetype)likeListModelWithDictionary:(NSDictionary *)dict;

@end
