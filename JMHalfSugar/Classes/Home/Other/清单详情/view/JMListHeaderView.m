//
//  JMListHeaderView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/21.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListHeaderView.h"
#import "JMLabel.h"
@interface UILabel (AttributeLabel)
+ (UILabel *)attributLabelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor lineSpacing:(CGFloat)lineSpaceing andTextEdgeInsets:(UIEdgeInsets)edgeInsets;
@end
@implementation UILabel (AttributeLabel)

+(UILabel *)attributLabelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor lineSpacing:(CGFloat)lineSpaceing andTextEdgeInsets:(UIEdgeInsets)edgeInsets
{
    
    return nil;
}

@end

@interface JMListHeaderView ()
@property (weak,nonatomic) UIImageView *imageView;
@property (weak,nonatomic) JMLabel *titileLabel;
@property (weak,nonatomic) JMLabel *subLabel;

@property (nonatomic, copy) NSString *titile;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, strong) UIImage *image;
@end

@implementation JMListHeaderView
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title subTitle:(NSString *)subTitle andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titile = title;
        self.subTitle = subTitle;
        self.image = image;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 342/2)];
    imageView.image = _image;
    [self addSubview:imageView];
    _imageView = imageView;
    JMLabel *titlelabel = [[JMLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), JMDeviceWidth, 96/2) title:_titile font:[UIFont systemFontOfSize:18.0]  textColor:JMMainTitleColor lineSpacing:0.0 andTextEdgeInsets:UIEdgeInsetsMake(10, 12, 0, 0)];
    [self addSubview:titlelabel];
    _titileLabel = titlelabel;
    
    JMLabel *subTitle =[[JMLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titlelabel.frame)+20, JMDeviceWidth, 100) title:_subTitle font:[UIFont systemFontOfSize:15.0] textColor:JMSubTitleColor lineSpacing:0.0 andTextEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
    [self addSubview:subTitle];
    _subLabel = subTitle;
    
    self.height = CGRectGetMaxY(_subLabel.frame)+20;
}
@end
