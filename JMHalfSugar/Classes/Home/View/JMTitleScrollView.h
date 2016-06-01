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
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, weak) id <JMTitleScrollViewDelegate> tDelegate;
- (void)setBottomViewAtIndex:(NSInteger)index;
@end
