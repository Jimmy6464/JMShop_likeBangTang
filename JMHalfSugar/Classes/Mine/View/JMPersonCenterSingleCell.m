//
//  JMPersonCenterSingleCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/7/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPersonCenterSingleCell.h"
#import "JMSearchSingleGoodsModel.h"

@interface JMPersonCenterSingleCell ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *likesCountLabel;
@property (nonatomic, strong) JMSearchSingleGoodsModel *model;
@end
@implementation JMPersonCenterSingleCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self intitilizedSubviews];
    }
    return self;
}
#pragma makr - initialized subviews
- (void)intitilizedSubviews
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 145, 145)];
    imageView.image = [UIImage imageNamed:@"placeHolder"];
    [self.contentView addSubview:imageView];
    _imageView = imageView;
    
    //
    UILabel *likesCountalabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 145, self.width, 25)];
    likesCountalabel.textAlignment = NSTextAlignmentCenter;
    likesCountalabel.textColor = JMMainTitleColor;
    likesCountalabel.font = [UIFont fontWithName:LightFont size:15.0];
    [self.contentView addSubview:likesCountalabel];
    self.likesCountLabel = likesCountalabel;
    
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andModel:(JMSearchSingleGoodsModel *)model
{
    static NSString *reuseIdentifier = @"JMPersonCenterSingleCell";
    JMPersonCenterSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = model;
    return cell;
}
- (void)setModel:(JMSearchSingleGoodsModel *)model
{
    _model = model;
    if (_model) {
        [self.imageView  sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        self.likesCountLabel.text = [NSString stringWithFormat:@"%@喜欢",_model.likeNumbers];
    }
}
@end
