//
//  JMBannerView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMBannerView.h"
#import "JMDailyBannerModel.h"
@interface JMBannerView ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *showScrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *goodBtn;
@property (nonatomic, strong) UIButton *plantGrassBtn;
@property (nonatomic, strong) UIButton *signInBtn;

@property (nonatomic, strong) NSMutableArray *bannerArray;
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
- (void)initializedSubviews
{
    UIScrollView *showScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 324/2)];
    showScrollView.delegate = self;
    showScrollView.pagingEnabled = YES;
    showScrollView.bounces = NO;
    showScrollView.showsHorizontalScrollIndicator = NO;
    
    UIImageView *lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 324/2)];
    JMDailyBannerModel *bannerModel = self.bannerArray[_bannerArray.count-1];
    
}
@end
