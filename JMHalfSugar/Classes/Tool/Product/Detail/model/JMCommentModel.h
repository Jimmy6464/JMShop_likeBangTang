//
//  JMCommentModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMAuthor;
@interface JMCommentModel : NSObject
/*
 *  id
 */
@property (nonatomic, copy) NSString *ID;
/*
 *  user id
 */
@property (nonatomic, copy) NSString *user_id;
/*
 *  nick name
 */
@property (nonatomic, copy) NSString *nickname;
/*
 *  headerImageURL
 */
@property (nonatomic, copy) NSString *headerImageURL;
/*
 *  content
 */
@property (nonatomic, copy) NSString *content;
/*
 *  is had replied someone
 */
@property (nonatomic, assign) BOOL isReplyed;
/*
 *  the date of created
 */
@property (nonatomic, copy) NSString *createTime;
/*
 *  like count
 */
@property (nonatomic, copy) NSString *praiseCount;
/*
 *  is liked
 */
@property (nonatomic, assign) BOOL is_praise;
/*
 *  is hot
 */
@property (nonatomic, assign) BOOL is_hot;
/*
 *  is officail
 */
@property (nonatomic, assign) BOOL is_offcial;
/*
 *  the one who was @
 */
@property (nonatomic, strong) JMAuthor *at_User;
/*
 *  cell adopt height
 */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)commentWithDictionary:(NSDictionary *)dict;
@end
