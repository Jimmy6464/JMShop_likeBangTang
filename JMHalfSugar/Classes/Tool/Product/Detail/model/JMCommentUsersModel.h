//
//  JMCommentUsersModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMCommentUsersModel : NSObject
/*
 *  user id
 */
@property (nonatomic, copy) NSString *user_id;
/*
 *  nickName
 */
@property (nonatomic, copy) NSString *nickname;
/*
 *  imagesUrl
 */
@property (nonatomic, copy) NSString *imageUrl;
+ (instancetype)commentUserWithDictionary:(NSDictionary *)dict;
@end
