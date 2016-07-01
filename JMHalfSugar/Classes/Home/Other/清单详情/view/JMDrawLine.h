//
//  JMDrawLine.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/23.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RealLine,
    DottedLine,
    BrokenLine,
} DrawType;
@interface JMDrawLine : UIView
- (void)drawDottedLine;
- (void)createBrokenLine:(NSDictionary *)titleDict;
+ (void)createLineInView:(DrawType)drawType contentView:(UIView *)contentView titleDict:(NSDictionary *)titleDict;
+ (JMDrawLine *)createLineInRect:(CGRect)lineRect drawType:(DrawType)drawType;
@end
