//
//  UIAlertController+JMShowTips.h
//  EasyPay_HD
//
//  Created by Jimmy on 16/5/26.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (JMShowTips)
+ (void)showAlertTips:(NSString *)tips onView:(UIView *)view alertStyle:(UIAlertControllerStyle)style timeInterval:(CGFloat)timeIterval compeletion:(void (^)(void))compeletion;

@end
