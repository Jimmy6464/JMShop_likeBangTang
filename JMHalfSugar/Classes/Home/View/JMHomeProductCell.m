//
//  JMHomeProductCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMHomeProductCell.h"
#import "JMProductRecommendModel.h"
@interface JMHomeProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end
@implementation JMHomeProductCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"JMHomeProductCell" owner:nil options:nil]lastObject];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseIdentifier = @"JMHomeProductCell";
    JMHomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMHomeProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}
- (void)setModel:(JMProductRecommendModel *)model
{
    _model = model;
    if (!_model) {
        return;
    }
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    self.imageV = self.productImageView;
    self.titleLable.text = model.tags;
    self.likeLabel.text =[NSString stringWithFormat:@"喜欢:%@", model.likes];
}
@end
