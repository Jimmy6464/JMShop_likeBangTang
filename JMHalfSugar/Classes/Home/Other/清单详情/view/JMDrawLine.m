//
//  JMDrawLine.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/23.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMDrawLine.h"

@interface JMDrawLine ()
@property (nonatomic, assign) DrawType drawType;
@property (nonatomic, assign) CGRect lineRect; // for dotted line
@end
@implementation JMDrawLine
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.drawType == DottedLine) {
        [self drawDottedLine];
    }
}
- (void)drawDottedLine
{
    CAShapeLayer *dottedLineLayer = [CAShapeLayer new];
    //draw path
    CGMutablePathRef path =  CGPathCreateMutable();
    dottedLineLayer.fillColor = [UIColor clearColor].CGColor;
    dottedLineLayer.strokeColor = JMGrayLineColor.CGColor;
    dottedLineLayer.lineWidth = self.height;
    
    NSArray *shapeArr = @[@1,@1];
    dottedLineLayer.lineDashPattern = shapeArr;
    
    CGPathMoveToPoint(path, nil, self.x, 0);
    CGPathAddLineToPoint(path, nil, self.x+self.width, 0);
    
    dottedLineLayer.path = path;
    [self.layer addSublayer:dottedLineLayer];
}
- (void)createBrokenLine:(NSDictionary *)titleDict
{
    CGFloat center_Xstr = 0.0;
    if ([titleDict[@"x"] isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = titleDict[@"x"];
        center_Xstr = tmp.floatValue;
    }else if ([titleDict isKindOfClass:[NSString class]]){
        NSString *tmp  = titleDict[@"x"];
        center_Xstr = tmp.floatValue;
    }
    
    CGFloat centerX = center_Xstr*self.width;
    
    CGFloat center_Ystr = 0.0;
    if ([titleDict[@"y"] isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = titleDict[@"y"];
        center_Ystr = tmp.floatValue;
    }else if ([titleDict isKindOfClass:[NSString class]]){
        NSString *tmp  = titleDict[@"y"];
        center_Ystr = tmp.floatValue;
    }
    
    CGFloat centerY = center_Ystr*self.height;
    
    CGPoint center = CGPointMake(centerX, centerY);
    //
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, 16.0, 16.0)];
    centerView.center = center;
    centerView.layer.cornerRadius = 8.0;
    [self addSubview:centerView];
    
    //two top point
    CGPoint topPoint1 = CGPointMake(centerX-18, centerY-40);
    CGPoint topPoint2 = CGPointMake(centerX-42, centerY-40);
    
    //right point
    CGPoint rightPoint = CGPointMake(centerX+22, centerY);
    //bottom point
    CGPoint bottonPoint1 = CGPointMake(centerX-18, centerY+40);
    CGPoint bottonPoint2 = CGPointMake(centerX-42, centerY+40);
    
    //draw path
    CAShapeLayer *drawLayer = [CAShapeLayer new];
    CGMutablePathRef path = CGPathCreateMutable();
    drawLayer.fillColor = [UIColor clearColor].CGColor;
    drawLayer.strokeColor = [UIColor colorWithHexString:@"000000"].CGColor;
    drawLayer.lineWidth = 1.0;
    
    NSArray *shapeArray = @[@10,@0];
    drawLayer.lineDashPattern = shapeArray;
    
    NSString *text1 = titleDict[@"text1"];
    [self addSubview:[self titleLabelWithTitle:text1 sidePoint:topPoint2 type:2]];
    CGPathMoveToPoint(path, nil, centerX, centerY);
    [self moveAndDrawLine:path endPoint:topPoint1];
    [self moveAndDrawLine:path endPoint:topPoint2];
    
    NSString *text2 = titleDict[@"text2"];
    [self addSubview:[self titleLabelWithTitle:text2 sidePoint:rightPoint type:1]];
    CGPathMoveToPoint(path, nil, centerX, centerY);
    [self moveAndDrawLine:path endPoint:rightPoint];
    
    NSString *text3 = titleDict[@"text3"];
    [self addSubview:[self titleLabelWithTitle:text3 sidePoint:bottonPoint2 type:2]];
    CGPathMoveToPoint(path, nil, centerX, centerY);
    [self moveAndDrawLine:path endPoint:bottonPoint1];
    [self moveAndDrawLine:path endPoint:bottonPoint2];
    
    drawLayer.path = path;
    [self.layer addSublayer:drawLayer];
}
- (void)moveAndDrawLine:(CGMutablePathRef)path endPoint:(CGPoint)endPoint
{
    CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y);
    CGPathMoveToPoint(path, nil, endPoint.x, endPoint.y);
}
- (UILabel *)titleLabelWithTitle:(NSString *)title sidePoint:(CGPoint)sidePoint type:(NSInteger)type
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11.0];
    label.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.6];
    label.layer.cornerRadius = 10.0;
    label.layer.masksToBounds = YES;
    [label sizeToFit];
    
    CGRect rect = CGRectZero;
    if (type == 1) {
        //the boundary of left
        rect = CGRectMake(sidePoint.x, sidePoint.y-label.height, label.width+34, label.height+14);
    }else if (type == 2){
        //the boundary of right
        rect = CGRectMake(sidePoint.x- label.width-34, sidePoint.y-7, label.width+34, label.height +14);
    }
    label.frame = rect;
    
    //if the label is over the screnn,reduce the font
    if (CGRectGetMaxX(label.frame) > JMDeviceWidth) {
        label.font = [UIFont systemFontOfSize:8.0];
        [label sizeToFit ];
        label.frame = CGRectMake(sidePoint.x, sidePoint.y - (label.height + 10)/2, label.width+20, label.height+10);
        label.layer.cornerRadius = 2.0;

    }else if(label.frame.origin.x < 0){
        label.font = [UIFont systemFontOfSize:8.0];
        [UIFont systemFontOfSize:8.0];
        label.frame = CGRectMake(sidePoint.x - label.width - 10, sidePoint.y - 5, label.width+10, label.height+10);
        label.layer.cornerRadius = 2.0;
    }
    
    return label;

}
+ (JMDrawLine *)createLineInRect:(CGRect)lineRect drawType:(DrawType)drawType
{
    JMDrawLine *line = [[JMDrawLine alloc]initWithFrame:lineRect];
    line.backgroundColor = [UIColor clearColor];
    line.lineRect = lineRect;
    line.drawType = drawType;
    return line;
}
+ (void)createLineInView:(DrawType)drawType contentView:(UIView *)contentView titleDict:(NSDictionary *)titleDict
{
    JMDrawLine *lineView = [[JMDrawLine alloc]initWithFrame:contentView.frame];
    lineView.backgroundColor = [UIColor clearColor];
    [lineView createBrokenLine:titleDict];
    [contentView addSubview:lineView];
}
@end
