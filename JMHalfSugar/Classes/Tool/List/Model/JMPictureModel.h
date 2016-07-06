//
//  JMPictureModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMPictureModel : NSObject
/*
 *  图片URL
 */
@property (nonatomic, copy) NSString *imageUrl;
/*
 *  image width
 */
@property (nonatomic, assign) CGFloat im_width;
/*
 *  image height
 */
@property (nonatomic, assign) CGFloat im_height;
@end
