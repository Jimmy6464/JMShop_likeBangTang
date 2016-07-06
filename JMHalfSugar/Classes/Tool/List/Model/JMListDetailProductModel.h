//
//  JMListDetailProductModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMPictureModel,JMLikeListModel;

@interface JMListDetailProductModel : NSObject
/*
 *  商品id
 */
@property (nonatomic, copy) NSString *productID;
/*
 *  topic _id
 */
@property (nonatomic, copy) NSString *topic_id;
/*
 *  商品图片数组
 */
@property (nonatomic, strong) NSArray<JMPictureModel *> *picArray;
/*
 *  ccategory
 */
@property (nonatomic, copy) NSString *category;
/*
 *  商品名称
 */
@property (nonatomic, copy) NSString *productName;
/*
 *  详情描述
 */
@property (nonatomic, copy) NSString *detailText;
/*
 *  价格
 */
@property (nonatomic, copy) NSString *price;
/*
 *  商品的链接：包括 淘宝，京东，亚马逊等
 */
@property (nonatomic, copy) NSString *productUrl;
/*
 *  商品所在平台
 */
@property (nonatomic, copy) NSString *platform;
/*
 *  是否评论过该商品
 */
@property (nonatomic, copy) NSString *iscomments;
/*
 *  评论次数
 */
@property (nonatomic, copy) NSString *comments;
/*
 *  是否已经收藏
 */
@property (nonatomic, assign) BOOL isLike;
/*
 *  喜欢人数
 */
@property (nonatomic, copy) NSString *likeNumbers;
/*
 *  喜欢列表
 */
@property (nonatomic, strong) NSArray *likes_list;
/*
 *  cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)listDeatilProductWithDictionary:(NSDictionary *)dict;
@end
