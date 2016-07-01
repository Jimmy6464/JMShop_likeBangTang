//
//  JMPersonCenterListCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/7/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPersonCenterListCell.h"
#import "JMProductRecommendModel.h"
@interface JMPersonCenterListCell ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *likeLabel;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, copy) NSString *listID;
@property (nonatomic, strong) JMProductRecommendModel *model;
@end
@implementation JMPersonCenterListCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark -initializedSubviews
- (void)initializedSubviews
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 342/2, JMDeviceWidth, 63/2)];
    titleLabel.tag = 110;
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = JMMainTitleColor;
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //
    UILabel *likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 342/2+63/2, JMDeviceWidth, 63/2)];
    likeLabel.tag = 110;
    likeLabel.font = [UIFont systemFontOfSize:16.0];
    likeLabel.textAlignment = NSTextAlignmentCenter;
    likeLabel.textColor = JMMainTitleColor;
    [self.contentView addSubview:likeLabel];
    _likeLabel = likeLabel;
 
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 171)];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}
- (void)setModel:(JMProductRecommendModel *)model
{
    _model = model;
    if (_model) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        self.likeLabel.text = [NSString stringWithFormat:@"喜欢:%@", _model.likes];
        self.titleLabel.text  = _model.title;
        self.listID  = _model.productID;
    }
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andModel:(JMProductRecommendModel *)model
{
    static NSString *reuseIdentifier = @"JMPersonCenterListCell";
    JMPersonCenterListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = model;
    return cell;
}
@end
