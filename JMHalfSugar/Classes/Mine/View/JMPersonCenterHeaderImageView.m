//
//  JMPersonCenterHeaderImageView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPersonCenterHeaderImageView.h"
#import "JMImageOperationCenter.h"
#import "JMDoubleLabel.h"
@interface JMPersonCenterHeaderImageView ()
@property (nonatomic, weak)UIButton *headerButton;
@property (nonatomic, strong)UIImage *avatarImage;
@property (nonatomic, weak)UILabel *nameLabel;
@property (nonatomic, weak)UILabel *bioLable;
@property (nonatomic, weak)JMDoubleLabel *achievementLabel;
@property (nonatomic, weak)JMDoubleLabel *goodSelectedLabel;
@property (nonatomic, weak)JMDoubleLabel *praiseLabel;
@end
@implementation JMPersonCenterHeaderImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.avatarImage = [UIImage imageNamed:@"headerImage"];
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    //
    UIImage *image = [JMImageOperationCenter headerImageOperationWithImage:_avatarImage borderColor:[UIColor whiteColor] andBorderWidth:2.0];
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake(JMDeviceWidth/2-30, 50, 60, 60);
    [headerBtn setImage:image forState:UIControlStateNormal];
    [headerBtn setImage:image forState:UIControlStateHighlighted];
    headerBtn.imageView.layer.cornerRadius = 30.0;
    headerBtn.layer.masksToBounds  = YES;
    headerBtn.clipsToBounds = YES;
    [headerBtn addTarget:self action:@selector(clickedAvataImage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headerBtn];
    _headerButton = headerBtn;
    //
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerButton.frame)+13, JMDeviceWidth, 15)];
    nameLabel.font = [UIFont fontWithName:RegularFont size:15.0];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"Stephy";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    //
    UILabel *bioLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLabel.frame)+13, JMDeviceWidth, 15)];
    bioLabel.font = [UIFont fontWithName:LightFont size:13.0];
    bioLabel.textColor = [UIColor whiteColor];
    bioLabel.text = @"Nothing is impossible";
    bioLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:bioLabel];
    self.bioLable = bioLabel;
    
    //
    CGFloat margin = (JMDeviceWidth-3*50-64)/2;
    //achievement
    JMDoubleLabel *achLabel = [[JMDoubleLabel alloc]initWithFrame:CGRectMake(32, CGRectGetMaxY(self.bioLable.frame)+15, 50, 45) topTitle:@"99" andBottomTitle:@"成就"];
    [self addSubview:achLabel];
    self.achievementLabel = achLabel;
    //good selected
    JMDoubleLabel *gselectedLabel = [[JMDoubleLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_achievementLabel.frame)+margin, CGRectGetMaxY(self.bioLable.frame)+15, 50, 45) topTitle:@"998" andBottomTitle:@"上精选"];
    [self addSubview:gselectedLabel];
    self.goodSelectedLabel = gselectedLabel;
    //praise
    JMDoubleLabel *praiseLabel = [[JMDoubleLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_goodSelectedLabel.frame)+margin, CGRectGetMaxY(self.bioLable.frame)+15, 50, 45) topTitle:@"1990" andBottomTitle:@"打賞"];
    [self addSubview:praiseLabel];
    self.praiseLabel = praiseLabel;
}
#pragma mark - event
- (void)clickedAvataImage:(UIButton *)btn
{
    NSLog(@"avatar");
    clickedImage();
}
- (void)changeAvatar:(UIImage *)image
{
    self.avatarImage = image;
    [self.headerButton setImage:self.avatarImage forState:UIControlStateNormal];
    [self.headerButton setImage:self.avatarImage forState:UIControlStateHighlighted];
}
@end
