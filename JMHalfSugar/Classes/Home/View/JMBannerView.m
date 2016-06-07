//
//  JMBannerView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMBannerView.h"
#import "JMDailyBannerModel.h"
#import "UIImageView+WebCache.h"
@interface JMBannerView ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *showScrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *goodBtn;
@property (nonatomic, strong) UIButton *plantGrassBtn;
@property (nonatomic, strong) UIButton *signInBtn;

@property (nonatomic, strong) NSMutableArray *bannerArray;
@end
@implementation JMBannerView
NSTimer *_timer =nil;
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
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.imageUrl] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
    [showScrollView addSubview:lastImageView];
    
    UIImageView *firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake((_bannerArray.count+1)*JMDeviceWidth, 0, JMDeviceWidth, 324/2)];
    JMDailyBannerModel *model = self.bannerArray[0];
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
    [showScrollView addSubview:firstImageView];
    
    for (int i = 0; i < self.bannerArray.count; i++) {
        JMDailyBannerModel *dailyModel = self.bannerArray[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(JMDeviceWidth*(i+1), 0, JMDeviceWidth, 324/2)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dailyModel.imageUrl] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
        [showScrollView addSubview:imageView];
    }
    showScrollView.contentSize = CGSizeMake(JMDeviceWidth*(self.bannerArray.count+2), 324/2);
    showScrollView.contentOffset = CGPointMake(JMDeviceWidth, 0);
    [self addSubview:showScrollView];
    _showScrollView = showScrollView;
    
    //create pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
    pageControl.numberOfPages = self.bannerArray.count;
    CGSize size = [pageControl sizeForNumberOfPages:self.bannerArray.count];
    pageControl.frame = CGRectMake(0, 150, size.width, 6);
    pageControl.layer.zPosition = 2;
    pageControl.centerX =JMDeviceWidth/2;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:99/255.0 blue:99/255.0 alpha:1.0];
    [pageControl addTarget:self action:@selector(pageControlValueChanged) forControlEvents:UIControlEventValueChanged];
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}
- (void)starTimer
{
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(autoMaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)autoMaticScroll
{
    if (_showScrollView.contentOffset.x == (self.bannerArray.count+1)*JMDeviceWidth) {
        //swipe to last one
        _showScrollView.contentOffset = CGPointMake(JMDeviceWidth, 0);
        _pageControl.currentPage = 0;
    }else{
        NSInteger page = (_showScrollView.contentOffset.x -JMDeviceWidth)/JMDeviceWidth;
        _pageControl.currentPage = page;
    }
    [self.showScrollView setContentOffset:CGPointMake(_showScrollView.contentOffset.x, 0) animated:YES];
}
- (void)pageControlValueChanged
{
    
}
@end
