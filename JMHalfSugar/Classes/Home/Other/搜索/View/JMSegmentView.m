//
//  JMSegmentView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSegmentView.h"
#import "UIColor+Hex.h"
@interface JMSegmentView ()
@property (nonatomic, weak)UILabel *firstLabel;
@property (nonatomic, copy)NSString *firstTitle;
@property (nonatomic, weak)UILabel *secondLabel;
@property (nonatomic, copy)NSString *secondTitle;
@property (nonatomic, weak)UIView *indicatorView;
@property (nonatomic, strong)UIView *middleLine;
@property (nonatomic, weak)UIView *topLine;
@property (nonatomic, weak)UIView *bottomLline;

@end
@implementation JMSegmentView
- (instancetype)initWithFrame:(CGRect)frame firstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.normalColor = JMColor(109, 109, 109);
        self.firstTitle = firstTitle;
        self.secondTitle = secondTitle;
        self.highlightColor = JMCustomBarTintColor;
        [self initializeSubviews];
    }
    return self;
}
- (void)initializeSubviews
{
    UILabel *firstLabel = [[UILabel alloc]init];
    firstLabel.tag = 1;
    firstLabel.userInteractionEnabled = YES;
    firstLabel.text = _firstTitle;
    firstLabel.font = [UIFont systemFontOfSize:16.0];
    firstLabel.textColor = _normalColor;
    [firstLabel sizeToFit];
    firstLabel.frame = CGRectMake(00, 0, firstLabel.width, firstLabel.height);
    firstLabel.center = CGPointMake(self.width/4, self.height/2);
    [firstLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedLabel:)]];
    [self addSubview:firstLabel];
    _firstLabel = firstLabel;
    //
    UILabel *secondLabel = [[UILabel alloc]init];
    secondLabel.tag = 2;
    secondLabel.userInteractionEnabled = YES;
    secondLabel.text = _secondTitle;
    secondLabel.font = [UIFont systemFontOfSize:16.0];
    secondLabel.textColor = _normalColor;
    [secondLabel sizeToFit];
    secondLabel.frame = CGRectMake(00, 0, firstLabel.width, firstLabel.height);
    secondLabel.center = CGPointMake(self.width/4*3, self.height/2);
    [secondLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedLabel:)]];
    [self addSubview:secondLabel];
    _secondLabel = secondLabel;
    
    //midel line
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.width/2-0.5, 0, 1, self.height*2/3)];
    lineView.centerY = self.height/2;
    lineView.backgroundColor = [UIColor colorWithHexString:@"D8D8D8"];
    [self addSubview:lineView];
    _middleLine = lineView;
    
    //top line
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    topLine.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    [self addSubview:topLine];
    _topLine = topLine;
    
    //bottom line
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    [self addSubview:bottomLine];
    _bottomLline = bottomLine;
    
    //bottom indicator
    self.currentIndex = 0;//default 0 ,the first one

    UIView *indicatorViwe = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-3, firstLabel.width, 3)];
    indicatorViwe.centerX = firstLabel.centerX;
    indicatorViwe.backgroundColor = JMCustomBarTintColor;
    [self addSubview:indicatorViwe];
    _indicatorView = indicatorViwe;
    
    
}
- (void)clickedLabel:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        label.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        label.transform = CGAffineTransformIdentity;
    }];
    if (_currentIndex != label.tag-1) {
        [self.delegate clickSegmentViewAtIndex:label.tag];
        self.currentIndex = label.tag-1;
    }
}
- (void)setCurrentIndex:(CGFloat)currentIndex
{
    _currentIndex = currentIndex;
    CGFloat centerX;
    if (_currentIndex == 0) {
        centerX = _firstLabel.centerX;
        _firstLabel.textColor = self.highlightColor;
        _secondLabel.textColor = self.normalColor;
    }else {
        centerX = _secondLabel.centerX;
        _firstLabel.textColor = _normalColor;
        _secondLabel.textColor = self.highlightColor;
    }
    __weak JMSegmentView *weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.indicatorView.centerX = centerX;
    }];
}
- (void)setShowIndicator:(BOOL)showIndicator
{
    _showIndicator = showIndicator;
    _indicatorView.hidden = _showIndicator;
}
- (void)setShowMidelSeparator:(BOOL)showMidelSeparator
{
    _showMidelSeparator = showMidelSeparator;
    _middleLine.hidden = _showMidelSeparator;

}
- (void)setShowTopBottomSeparator:(BOOL)showTopBottomSeparator
{
    _showTopBottomSeparator = showTopBottomSeparator;
    _topLine.hidden = _showTopBottomSeparator;
    _bottomLline.hidden = _showTopBottomSeparator;
}
@end
