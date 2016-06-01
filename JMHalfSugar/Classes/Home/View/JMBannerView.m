//
//  JMBannerView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMBannerView.h"

@interface JMBannerView ()
@property (nonatomic, weak) UIScrollView *showScrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end
@implementation JMBannerView

#pragma mrak - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

@end
