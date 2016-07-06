//
//  JMImageOperationCenter.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMImageOperationCenter.h"

@implementation JMImageOperationCenter
+ (void)gaussianBlurWithCoreImage:(UIImageView *)imageView
{
    UIImage  *image = imageView.image;
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //滤镜效果
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    CIImage *beginImage = [CIImage imageWithCGImage:image.CGImage];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    [filter setValue:@8.0 forKey:@"inputRadius"];

    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    image = [UIImage imageWithCGImage:[context createCGImage:result fromRect:result.extent]];
    
    imageView.image = image;

}

// 图片 按比例缩放  缩放比例 按照 图片最接近理想宽度 那条边
/**
 图片 按比例缩放
 
 - parameter image:     输入图片
 - parameter goalWidth: 目标缩放宽度
 
 - returns: 输出图片
 */
+ (UIImage *)scaleImage:(UIImage *)image withGoalWidth:(CGFloat)width
{
    CGFloat scale = 0.0;
    if ((width -image.size.width) > (width-image.size.height)) {
        //width < height
        scale = width/image.size.width;
    }else {
        scale  = width/image.size.height;
    }
    CGSize goalSize = CGSizeMake(scale*image.size.width, scale*image.size.height);
    UIGraphicsBeginImageContext(goalSize);
    [image drawInRect:CGRectMake(0, 0, goalSize.width, goalSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
// 图片大小是 60 * 60 的  不用再次修改大小
+ (UIImage *)headerImageOperationWithImage:(UIImage *)image borderColor:(UIColor *)borderColor andBorderWidth:(CGFloat)borderWidth
{
    
    //开启上下文
    CGSize  sizeImage = image.size;
    
    UIGraphicsBeginImageContextWithOptions(sizeImage, false, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画边框  大圆
    [borderColor set];
    CGContextAddArc(ctx, image.size.width/2, image.size.height/2, image.size.height/2, 0, (M_PI * 2.0) , 0);
    CGContextFillPath(ctx);
    
    //画小圆
    CGContextAddArc(ctx, image.size.width/2, image.size.width/2, image.size.width/2 - borderWidth, 0, (M_PI * 2.0), 0);
    CGContextClip(ctx);
    
    //画图
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    
    //取图
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
// 从相机拍照  后修改

+ (UIImage *)headerImageFromCamera:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    //开启上下文
    CGSize sizeImage = image.size;
    
    UIGraphicsBeginImageContextWithOptions(sizeImage, false, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画边框  大圆
    [borderColor set];
    CGContextAddArc(ctx, image.size.width/2, image.size.height/2, 30, 0, (M_PI * 2.0) , 0);
    CGContextFillPath(ctx);
    
    //画小圆
    CGContextAddArc(ctx, image.size.width/2, image.size.width/2, 30 - borderWidth, 0, (M_PI * 2.0), 0);
    CGContextClip(ctx);
    
    //画图
    [image drawInRect:CGRectMake(30+borderWidth, 30+borderWidth, 60, 60)];
    
    //取图
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
