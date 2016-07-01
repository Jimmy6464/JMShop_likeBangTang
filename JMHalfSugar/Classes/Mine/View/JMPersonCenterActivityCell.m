//
//  JMPersonCenterActivityCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/7/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPersonCenterActivityCell.h"
#import "JMUserRecommendModel.h"
#import "JMLabel.h"
#import "JMUserRecommendDynamicModel.h"
#import "JMUserRecommendProductModel.h"
@interface JMPersonCenterActivityCell ()
@property (nonatomic, weak)UIImageView *imageView;
@property (nonatomic, weak)JMLabel *detailLabel;
@property (nonatomic, weak)UIButton *likeButton;
@property (nonatomic, strong)JMUserRecommendModel *model;
@end
@implementation JMPersonCenterActivityCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 145, 145)];
    imageView.image = [UIImage imageNamed:@"placeHolder"];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    JMLabel *detailLabel = [[JMLabel alloc]initWithFrame:CGRectMake(0, 145, 145, 120) title:@"" font:[UIFont fontWithName:LightFont size:14.0] textColor:JMMainTitleColor lineSpacing:4.0 andTextEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    detailLabel.clipsToBounds = YES;
    [self.contentView addSubview:detailLabel];
    _detailLabel = detailLabel;
    
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeBtn setImage:[UIImage imageNamed:@"addToFavorite_selected"] forState:UIControlStateNormal];
    likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [likeBtn setTitleColor:JMSubTitleColor forState:UIControlStateNormal];
    likeBtn.titleLabel.font = [UIFont fontWithName:LightFont size:12.0];
    [self.contentView addSubview:likeBtn];
    self.likeButton = likeBtn;
    
}
- (void)setModel:(JMUserRecommendModel *)model
{
    _model = model;
    if (_model) {
        JMUserRecommendProductModel *product = [_model.productArray objectAtIndex:0];
        JMUserRecommendDynamicModel *dynamic = _model.dynamic;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:product.picUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        self.detailLabel.title = _model.content;
        self.detailLabel.frame = CGRectMake(0, 145, 145, 47);
        
        [self.likeButton setTitle:dynamic.likes forState:UIControlStateNormal];
        self.likeButton.frame = CGRectMake(self.width-28-12*dynamic.likes.length, 60+145, 28+12*dynamic.likes.length, 23.0);
        
        
    }
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andModel:(JMUserRecommendModel *)model
{
    static NSString *reuseIdentifier = @"JMPersonCenterActivityCell";
    JMPersonCenterActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = model;
    return cell;
}
@end
