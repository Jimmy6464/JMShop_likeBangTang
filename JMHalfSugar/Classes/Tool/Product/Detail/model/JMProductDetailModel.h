//
//  JMProductDetailModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailProductModel.h"
@class JMCommentModel,JMCommentUsersModel;
@interface JMProductDetailModel : JMListDetailProductModel
/*
 *  comment list
 */
@property (nonatomic, strong) NSArray *comment_list;
/*
 *  share URL
 */
@property (nonatomic, copy) NSString *share_URL;
/*
 *  like users
 */
@property (nonatomic, strong) NSArray *likeUser;


/*
 islike,
 comments,
 product{},
 id,
 likes_list[],
 comment_list[],
 likes,
 commodity,
 iscomments
 */
+ (instancetype)productDetailModelWithDictionary:(NSDictionary *)dict;
@end
