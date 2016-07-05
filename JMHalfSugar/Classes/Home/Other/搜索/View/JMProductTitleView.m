//
//  JMProductTitleView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductTitleView.h"
#import "JMProductDetailModel.h"
#import "JMPictureModel.h"
@interface JMProductTitleView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *proNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@property (weak, nonatomic) UIPageControl *pageControl;

@end
@implementation JMProductTitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"JMProductTitleView" owner:nil options:nil]lastObject];
        self.frame = frame;
    }
    return self;
}
- (void)awakeFromNib
{
    self.descriptionLabel.font = [UIFont fontWithName:LightFont size:15.0];
    self.descriptionLabel.textColor = JMSubTitleColor;
    self.proNameLabel.textColor = JMMainTitleColor;
}
- (void)setModel:(JMProductDetailModel *)model
{
    _model = model;
    NSArray *images = model.picArray;
    
    UIPageControl *pageControl = [UIPageControl new];
        pageControl.numberOfPages = images.count;
    CGSize sizeP = [pageControl sizeForNumberOfPages:images.count];

    pageControl.frame = CGRectMake(0, 250-14, sizeP.width, 6);

    pageControl.centerX = JMDeviceWidth/2;
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"E2D9D6"];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"FFFFFF"];
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    _pageControl = pageControl;
    
    __weak JMProductTitleView *weakSelf = self;
    _scrollView.contentSize = CGSizeMake(JMDeviceWidth*images.count, 250);

    
    [images enumerateObjectsUsingBlock:^(JMPictureModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj.imageUrl] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
        imageView.frame = CGRectMake(0+JMDeviceWidth*idx, 0, JMDeviceWidth, 250);
        [weakSelf.scrollView addSubview:imageView];
    }];
    _proNameLabel.text = _model.productName;
    _priceLabel.text =[NSString stringWithFormat:@"$%@", _model.price];
    _descriptionLabel.text = _model.detailText;
    CGSize size = [_descriptionLabel sizeThatFits:CGSizeMake(JMDeviceWidth-20, CGFLOAT_MAX)];
    _descriptionLabel.height = size.height;
    self.height = CGRectGetMaxY(_descriptionLabel.frame)+10;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.height = CGRectGetMaxY(_descriptionLabel.frame);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentIndex = (NSInteger)scrollView.contentOffset.x/JMDeviceWidth;
    _pageControl.currentPage = currentIndex;
}
- (void)setContentOffsetY:(CGFloat)contentOffsetY
{
    _contentOffsetY = contentOffsetY;
    _scrollViewHeight.constant = contentOffsetY;
    for (UIView *view in _scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)view;
            imageView.height = contentOffsetY;
        }
    }
    _pageControl.y = contentOffsetY-14;
    [self layoutIfNeeded];
}
@end
