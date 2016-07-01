//
//  JMTitleScrollerView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMTitleScrollView;
@protocol JMTitleScrollViewDelegate <NSObject>

- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index;

@end
@interface JMTitleScrollView : UIScrollView
@property (nonatomic, weak) id <JMTitleScrollViewDelegate> tDelegate;
- (void)setBottomViewAtIndex:(NSInteger)index;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles fontSize:(CGFloat)font _textLength:(CGFloat)length andButtonSpacing:(CGFloat)buttonSpacing;
/*
 TitleView(titleArr: NSArray(objects: "热门推荐","深夜食堂","变美神器","一种生活"), normalColor: MainTitleColor, highlightColor: CustomBarTintColor, fontSize: 15.0,textLength: 4.0,buttonSpacing: margin )
 */
@end
