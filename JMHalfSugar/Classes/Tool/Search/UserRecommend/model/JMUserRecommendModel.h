//
//  JMUserRecommendModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMUserRecommendTagsModel,JMUserRecommendProductModel,JMUserRecommendPicModel,JMUserRecommendDynamicModel,JMAuthor;
@interface JMUserRecommendModel : NSObject
/*
 *  userRecommendID
 */
@property (nonatomic, copy) NSString *userRecommendID;
/*
 *  recommended text
 */
@property (nonatomic, copy) NSString *content;
/*
 *  the date of created
 */
@property (nonatomic, copy) NSString *createTime;
/*
 *  author's id
 */
@property (nonatomic, copy) NSString *author_id;
/*
 *  user Dynamic
 */
@property (nonatomic, strong) JMUserRecommendDynamicModel *dynamic;
/*
 *  tags array
 */
@property (nonatomic, strong) NSArray<JMUserRecommendTagsModel *> *tagArray;
/*
 *  pictures's array
 */
@property (nonatomic, strong) NSArray<JMUserRecommendPicModel *> *picArray;
/*
 *  products' array
 */
@property (nonatomic, strong) NSArray<JMUserRecommendProductModel *> *productArray;
/*
 *  author
 */
@property (nonatomic, strong) JMAuthor *author;
/*
 *  shared url
 */
@property (nonatomic, copy) NSString *share_url;
/*
 *  cell's height
 */
@property (nonatomic, assign) CGFloat cellHeight;
+ (instancetype)userRecommendWithDictionary:(NSDictionary *)dict;
@end
