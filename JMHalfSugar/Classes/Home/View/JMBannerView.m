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
- (void)setBannerArray:(NSMutableArray *)bannerArray
{
    _bannerArray = bannerArray;
    [self initializedSubviews];
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
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.photo] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    [showScrollView addSubview:lastImageView];
    
    UIImageView *firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake((_bannerArray.count+1)*JMDeviceWidth, 0, JMDeviceWidth, 324/2)];
    JMDailyBannerModel *model = self.bannerArray[0];
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    [showScrollView addSubview:firstImageView];
    
    for (int i = 0; i < self.bannerArray.count; i++) {
        JMDailyBannerModel *dailyModel = self.bannerArray[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(JMDeviceWidth*(i+1), 0, JMDeviceWidth, 324/2)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dailyModel.photo] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
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
    
    //
    [self createButtons];
    [self starTimer];
}
- (void)createButtons
{
    CGFloat margin = (JMDeviceWidth- 45*4-24*2)/3;
    NSArray *images = @[@"GoodSomething",@"searchLarge",@"PlantingGrass",@"SignIn"];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *goodThing = [UIButton buttonWithType:UIButtonTypeCustom];
        goodThing.frame = CGRectMake(24+45*i+margin*i, 175, 45, 70);
        goodThing.tag = 1+i;
        [goodThing setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        goodThing.adjustsImageWhenDisabled = NO;
        [goodThing addTarget:self action:@selector(clickedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goodThing];
    }
}
- (void)starTimer
{
    _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(autoMaticScroll) userInfo:nil repeats:YES];
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
    [self.showScrollView setContentOffset:CGPointMake(_showScrollView.contentOffset.x+JMDeviceWidth, 0) animated:YES];
}
- (void)pageControlValueChanged
{
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //count the page
    NSInteger page = (NSInteger)(_showScrollView.contentOffset.x-JMDeviceWidth)/JMDeviceWidth;
    _pageControl.currentPage = page;
    //scroll to the first page
    if (_showScrollView.contentOffset.x == 0) {
        _showScrollView.contentOffset = CGPointMake(_bannerArray.count * JMDeviceWidth, 0);
        _pageControl.currentPage = _bannerArray.count - 1;
    }else if (_showScrollView.contentOffset.x == (_bannerArray.count+1)*JMDeviceWidth) {
        //scroll to the last page
        _showScrollView.contentOffset = CGPointMake(JMDeviceWidth, 0);
        _pageControl.currentPage = 0;
    }
    

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self starTimer];
}
#pragma mark - Button clicked method
- (void)clickedAction:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
            [self.delegate bannerButtonClickeWithType:GoodThingClickType];
            break;
        case 2:
            [self.delegate bannerButtonClickeWithType:SearchClickType];
            break;
        case 3:
            [self.delegate bannerButtonClickeWithType:PlantGrassClickType];
            break;
        case 4:
            [self.delegate bannerButtonClickeWithType:SignInClickType];
            break;
            
        default:
            break;
    }
}
@end
