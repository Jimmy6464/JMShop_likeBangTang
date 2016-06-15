//
//  JMSearchListCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchListCell.h"
#import "JMSerchLishModel.h"
@interface JMSearchListCell ()
@property (nonatomic, weak)UILabel *englishNameLabel;
@end
@implementation JMSearchListCell
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
    [super initializedSubviews];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 60, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = JMColor(153, 153, 153);
    label.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:label];
    _englishNameLabel = label;
}
- (void)setSearchListModel:(JMSerchLishModel *)searchListModel
{
    _searchListModel = searchListModel;
    [self.iconImageView  sd_setImageWithURL:[NSURL URLWithString:_searchListModel.iconUrl] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    self.nameLabel.text = _searchListModel.name;
    self.englishNameLabel.text = _searchListModel.en_name;
}
@end
