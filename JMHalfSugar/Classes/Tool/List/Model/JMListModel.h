//
//  JMListModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMListDetailProductModel;
@interface JMListModel : NSObject
/*
 *  listID
 */
@property (nonatomic, copy) NSString *listID;
/*
 *  listCategory
 */
@property (nonatomic, copy) NSString *category;
/*
 *  title
 */
@property (nonatomic, copy) NSString *title;
/*
 *  Description for detail
 */
@property (nonatomic, copy) NSString *detailText;
/*
 *  imageURl
 */
@property (nonatomic, copy) NSString *imageUrl;
/*
 *  likesNumber
 */
@property (nonatomic, copy) NSString *likesNum;
/*
 *  favorite
 */
@property (nonatomic, assign) BOOL islike;
/*
 *  list tag
 */
@property (nonatomic, copy) NSString *tags;
/*
 *  share URL
 */
@property (nonatomic, copy) NSString *share_url;
/*
 *  shareimage
 */
@property (nonatomic, copy) NSString *share_imageURL;
/*
 *  imageHost
 */
@property (nonatomic, copy) NSString *imageHost;
/*
 *  avatar imageHost
 */
@property (nonatomic, copy) NSString *user_avatr_host;
/*
 *  product array
 */
@property (nonatomic, strong) NSArray<JMListDetailProductModel *> *prouctArray;
+ (instancetype)listModelWithDictionary:(NSDictionary *)dict andListID:(NSString *)listID;
@end
