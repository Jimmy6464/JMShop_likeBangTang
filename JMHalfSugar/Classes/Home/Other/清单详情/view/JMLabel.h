//
//  JMLabel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/22.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMLabel : UIView
@property (nonatomic, copy) NSString *title;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)color lineSpacing:(CGFloat)lineSpacing andTextEdgeInsets:(UIEdgeInsets)edgeInsets;
@end
