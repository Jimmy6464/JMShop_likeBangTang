//
//  JMSegmentView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMSegmentViewDelegate <NSObject>

- (void)clickSegmentViewAtIndex:(NSInteger)index;

@end
@interface JMSegmentView : UIView
@property (nonatomic, assign)CGFloat currentIndex;
@property (nonatomic, assign)BOOL showIndicator;
@property (nonatomic, assign)BOOL showMidelSeparator;
@property (nonatomic, assign)BOOL  showTopBottomSeparator;
@property (nonatomic, assign)id <JMSegmentViewDelegate> delegate;
@property (nonatomic, strong)UIColor *normalColor;
@property (nonatomic, strong)UIColor *highlightColor;
- (instancetype)initWithFrame:(CGRect)frame firstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle;
@end
