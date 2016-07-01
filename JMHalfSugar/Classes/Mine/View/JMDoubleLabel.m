//
//  JMDoubleLabel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMDoubleLabel.h"

@interface JMDoubleLabel ()
@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) UILabel *bottomLabel;
@property (nonatomic, copy) NSString *topTitle;
@property (nonatomic, copy) NSString *bottomTitle;
@end
@implementation JMDoubleLabel


- (instancetype)initWithFrame:(CGRect)frame topTitle:(NSString *)topTitle andBottomTitle:(NSString *)bottomTitle;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self intializedSubviews];
        self.topTitle = topTitle;
        self.bottomTitle = bottomTitle;
    }
    return self;
}
#pragma mark - initialized subviews
- (void)intializedSubviews
{
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 14)];
    firstLabel.font = [UIFont fontWithName:LightFont size:14.0];
    firstLabel.textColor = [UIColor whiteColor];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:firstLabel];
    _topLabel = firstLabel;
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topLabel.frame)+8, 50, 14)];
    secondLabel.font = [UIFont fontWithName:LightFont size:14.0];
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:secondLabel];
    _bottomLabel = secondLabel;
}
#pragma mark - override set method
- (void)setTopTitle:(NSString *)topTitle
{
    _topTitle = topTitle;
    self.topLabel.text = topTitle;
}
- (void)setBottomTitle:(NSString *)bottomTitle
{
    _bottomTitle = bottomTitle;
    self.bottomLabel.text = _bottomTitle;
}
@end
