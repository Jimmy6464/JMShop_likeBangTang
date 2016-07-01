//
//  JMDailyBannerModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *  轮播图Model
 */
@interface JMDailyBannerModel : NSObject
/*
 *  bannerID
 */
@property (nonatomic, copy) NSString *bannerID;
/*
 *  title
 */
@property (nonatomic, copy) NSString *title;
/*
 *  subTitle
 */
@property (nonatomic, copy) NSString *subTitle;
/*
 *  type
 */
@property (nonatomic, copy) NSString *type;
/*
 *  imageUrl
 */
@property (nonatomic, copy) NSString *photo;
+ (instancetype)dailyBannerModelWithDictionary:(NSDictionary *)dict;

@end
