//
//  JMSingleCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSingleCell.h"

#import "JMSearchSingleGoodsModel.h"
@interface JMSingleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *proNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *proPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesNumLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;


@end
@implementation JMSingleCell

- (void)awakeFromNib {
    // Initialization code
    _imageHeight.constant = self.width-20;
}
- (void)setModel:(JMSearchSingleGoodsModel *)model
{
    _model = model;
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    _proNameLabel.text = model.productName;
    _descriptionLabel.text = model.detailText;
    _proPriceLabel.text =[NSString stringWithFormat:@"$%@",model.price];
    _likesNumLabel.text = model.likeNumbers;
}
@end
