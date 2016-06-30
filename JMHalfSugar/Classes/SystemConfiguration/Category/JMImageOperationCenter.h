//
//  JMImageOperationCenter.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMImageOperationCenter : NSObject

//利用 core Image做高斯模糊处理，， 耗时！！！！
+ (void)gaussianBlurWithCoreImage:(UIImageView *)imageView;
// 图片 按比例缩放  缩放比例 按照 图片最接近理想宽度 那条边
/**
 图片 按比例缩放
 
 - parameter image:     输入图片
 - parameter goalWidth: 目标缩放宽度
 
 - returns: 输出图片
 */
+ (UIImage *)scaleImage:(UIImage *)image withGoalWidth:(CGFloat)width;
+ (UIImage *)headerImageOperationWithImage:(UIImage *) image borderColor:(UIColor *)borderColor andBorderWidth:( CGFloat)borderWidth;
// 从相机拍照  后修改
+ (UIImage *)headerImageFromCamera:(UIImage*)image borderColor:(UIColor*)borderColor borderWidth:( CGFloat)borderWidth;
@end
