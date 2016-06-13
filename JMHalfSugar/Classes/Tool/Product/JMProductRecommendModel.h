//
//  JMProductRecommendModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/6.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
//清单推荐Model
@interface JMProductRecommendModel : NSObject
/*
 *  清单ID
 */
@property (nonatomic, copy) NSString *productID;
/*
 *  一级标题
 */
@property (nonatomic, copy) NSString *title;
/*
 *  二级标题
 */
@property (nonatomic, copy) NSString *tags;
/*
 *  图片url
 */
@property (nonatomic, copy) NSString *imageUrl;
/*
 *  喜欢人数
 */
@property (nonatomic, copy) NSString *likes;
/*
 *  是否已经喜欢
 */
@property (nonatomic, copy) NSString *islike;
/*
 *  更新时间
 */
@property (nonatomic, copy) NSString *updataTime;
/*
 *  清单类型
 */
@property (nonatomic, copy) NSString *type;
//清单推荐Model

+ (instancetype)productRecommendWithDictionary:(NSDictionary *)dict;

@end
