//
//  JMSearchSingleCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchSingleCell.h"

#import "JMSearchModel.h"
@implementation JMSearchSingleCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
#pragma mark - initialized subviews,such as iconImageView and nameLabel
- (void)initializedSubviews
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [self.contentView addSubview:imageView];
    _iconImageView = imageView;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconImageView.frame), 60, 20)];
    nameLabel.textColor = JMSubTitleColor;
    nameLabel.font = [UIFont systemFontOfSize:13.0];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;
}
- (void)setSearchModel:(JMSearchModel *)searchModel
{
    _searchModel = searchModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_searchModel.iconUrl] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    _nameLabel.text = _searchModel.name;
}

@end
