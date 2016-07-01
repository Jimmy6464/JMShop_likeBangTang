//
//  JMTitleScrollerView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMTitleScrollView.h"

@interface JMTitleScrollView ()
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, weak) UIView *indicator;//horizontalIndicator:red
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, assign)CGFloat buttonSpacing;
@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat textLength;
@end
@implementation JMTitleScrollView

NSInteger _currentPage = 0;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles fontSize:(CGFloat)font _textLength:(CGFloat)length andButtonSpacing:(CGFloat)buttonSpacing
{
    self = [super initWithFrame:frame];
    if (self) {
        self.normalColor = [UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:1.0];
        self.highlightColor = [UIColor redColor];
        self.buttonSpacing = buttonSpacing;
        self.titleArray = titles;
        _fontSize = font;
        _textLength = length;
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    for (NSInteger i = 0; i<_titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+100;
        btn.frame = CGRectMake(i*_textLength*_fontSize+_buttonSpacing*i+12, 8, _textLength*_fontSize, _fontSize+2);
        btn.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.highlightColor forState:UIControlStateSelected];

        [btn addTarget:self action:@selector(observeTitleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    //set the arrange of scrollerview
//    self.contentSize =  CGSizeMake(_titleArray.count*2*_fontSize+(_titleArray.count-1)*30+24, 36.0);
    self.backgroundColor = [UIColor whiteColor];
    self.showsHorizontalScrollIndicator = false;
    
    //
    UIView *indicator = [[UIView alloc]initWithFrame:CGRectMake(12, 34, _fontSize*_textLength, 2)];
    indicator.layer.zPosition = 2;
    indicator.backgroundColor = self.highlightColor;
    _currentPage = 0 ;
    [self addSubview:indicator];
    _indicator = indicator;
}
#pragma mark - button clicked
- (void)observeTitleButtonClicked:(UIButton *)btn
{
    if (btn.selected == YES) {
        return;
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
    btn.selected = YES;
    __weak JMTitleScrollView *weakSelf = self;
    NSInteger clickedIndex = btn.tag - 100;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.indicator.centerX  = btn.centerX;
    }];
    _currentPage  = clickedIndex;
    //
    [self.tDelegate clickedTitleView:self atIndex:clickedIndex];
}
#pragma mark - public method
- (void)setBottomViewAtIndex:(NSInteger)index
{
    __weak JMTitleScrollView *weakSelf = self;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
    UIButton *btn = (UIButton *)[self viewWithTag:index+100];
    btn.selected = YES;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.indicator.centerX = btn.centerX;
    } completion:^(BOOL finished) {
        _currentPage = index;
        if (index>1 && index <11) {
            //将指示器所指向的标签分类放置到屏幕中间
            CGFloat width = btn.x - self.contentOffset.x;
            //要移动的距离
            CGFloat length = width - JMDeviceWidth/2;
            [self setContentOffset:CGPointMake(self.contentOffset.x+length, 0) animated:YES];
        }
    }];
}
@end
