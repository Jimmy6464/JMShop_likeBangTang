//
//  JMListDetailCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/22.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailCell.h"
#import "JMLabel.h"
#import "JMListDetailProductModel.h"
#import "JMPictureModel.h"
#import "JMLikeListModel.h"
@interface JMListDetailCell ()
@property (nonatomic, weak)UILabel *countLabel;
@property (nonatomic, weak)JMLabel *titleLabel;
@property (nonatomic, weak)JMLabel *subTitleLable;
@property (nonatomic, weak)UILabel *priceLabel;//product price
@property (nonatomic, weak)UIView *showHeaderView;//avatar view and like's count
@property (nonatomic, weak)UILabel *likeNumberLabel;//the count of like people
@property (nonatomic, weak)UIView *showToolView;//commentBtn ,likeBtn and Buy btn
@property (nonatomic, strong) JMListDetailProductModel *model;
@property (nonatomic, strong)NSIndexPath *currentIndexPath;
@end
@implementation JMListDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    //
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 54/2-22/2, 20+2, 20+2)];
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.textColor = [UIColor whiteColor];
    countLabel.backgroundColor = JMCustomBarTintColor;
    countLabel.font = [UIFont systemFontOfSize:10.0];
    countLabel.layer.cornerRadius = 11.0;
    countLabel.layer.borderColor = [UIColor clearColor].CGColor;
    countLabel.layer.borderWidth = 4.0f;
    countLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:countLabel];
    _countLabel = countLabel;
    
    //price label
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    priceLabel.textColor = JMCustomBarTintColor;
    priceLabel.font = [UIFont systemFontOfSize:15.0];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    
    
    //
    UIView *showToolView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:showToolView];
    _showToolView = showToolView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(JMListDetailProductModel *)model
{
    _model = model;
    if (!_model) {
        return;
    }
    //product name
    JMLabel *titleLabel = [[JMLabel alloc]initWithFrame:CGRectMake(36, 0, JMDeviceWidth-44, 54) title:_model.productName font:[UIFont systemFontOfSize:18.0] textColor:JMMainTitleColor lineSpacing:0.0 andTextEdgeInsets:UIEdgeInsetsMake(17.0/2, 0, 0, 0)];
    [self.contentView addSubview:titleLabel];
    _titleLabel =titleLabel;
    
    //product detail
    JMLabel *subTitleLabel = [[JMLabel alloc]initWithFrame:CGRectMake(0, 54, JMDeviceWidth-10, 45) title:_model.detailText font:[UIFont systemFontOfSize:15.0] textColor:JMSubTitleColor lineSpacing:10.0 andTextEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:subTitleLabel];
    _subTitleLable = subTitleLabel;
    
    //product images;
    CGFloat orginY = CGRectGetMaxY(_subTitleLable.frame);
    if (_model.picArray.count>0) {
        for (NSInteger i= 0; i<_model.picArray.count; i++) {
            JMPictureModel *pictureModel = _model.picArray[i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, orginY+5, pictureModel.im_width/2 > JMDeviceWidth? JMDeviceWidth-20:pictureModel.im_width/2, pictureModel.im_height/2>JMDeviceWidth ? JMDeviceWidth-20:pictureModel.im_height/2)];
            imageView.tag = _model.productID.integerValue;
            imageView.userInteractionEnabled = YES;
            [imageView sd_setImageWithURL:[NSURL URLWithString:pictureModel.imageUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapRecognizer:)]];
            [self.contentView addSubview:imageView];
            orginY += JMDeviceWidth-20+5;
        }
    }
    //price label
    _priceLabel.frame = CGRectMake(0, orginY, JMDeviceWidth-15, 50.0);
    _priceLabel.text = [NSString stringWithFormat:@"参考价：$%@",_model.price];
    orginY = CGRectGetMaxY(_priceLabel.frame);
    
    //topLine
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, orginY, JMDeviceWidth, 1)];
    topLine.backgroundColor = JMLightLineColor;
    [self.contentView addSubview:topLine];
    
    //like's avatar list
    UIView *showHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, orginY, JMDeviceWidth, 75)];
    NSInteger showHeadNum = _model.likes_list.count>7 ? 7 :_model.likes_list.count;
    
    //the number of likes peopleX
    //like's label
    UILabel *likeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    likeLabel.font = [UIFont systemFontOfSize:12.0];
    likeLabel.textAlignment = NSTextAlignmentLeft;
    likeLabel.textColor = JMGrayLineColor;
    likeLabel.frame =  CGRectMake(10, 11, JMDeviceWidth, 14);
    likeLabel.text = [NSString stringWithFormat:@"%@人喜欢",_model.likeNumbers];
    [showHeaderView addSubview:likeLabel];
    _likeNumberLabel = likeLabel;
    
    CGFloat orginX = 10;
    for (NSInteger i = 0; i<showHeadNum; i++) {
        JMLikeListModel *likeList = _model.likes_list[i];
        UIImageView *avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(orginX, 32, 27, 27)];
        avatarImageView.layer.cornerRadius = 27/2;
        avatarImageView.layer.borderColor = [UIColor clearColor].CGColor;
        avatarImageView.layer.masksToBounds = YES;
        [avatarImageView sd_setImageWithURL:[NSURL URLWithString:likeList.headerImageUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        [showHeaderView addSubview:avatarImageView];
        orginX += 10+27;
    }
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JMDeviceWidth-15-14, 39, 9, 14)];
    arrowImageView.image = [UIImage imageNamed:@"subject_arrow_right"];
    [showHeaderView addSubview:arrowImageView];
    
    orginY += 75;
    [self.contentView addSubview:showHeaderView];
    _showHeaderView = showHeaderView;
    
    //
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, orginY-0.5, JMDeviceWidth, 0.5)];
    bottomLine.backgroundColor = JMLightLineColor;
    [self.contentView addSubview:bottomLine];
    
    //toolView
    _showToolView.frame = CGRectMake(0, orginY, JMDeviceWidth, 50);
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(33, 14, 40, 23);
    [commentBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateHighlighted];
    
    if (![_model.comments isEqualToString: @"0"]  &&  _model.comments.length != 0) {
        [commentBtn setTitle:_model.comments forState:UIControlStateNormal];
        [commentBtn setTitleColor:JMTitleGrayColor forState:UIControlStateNormal];
        commentBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        commentBtn.tag = AllowComment_type;
        
    }else if ([_model.comments isEqualToString: @""]){
        commentBtn.tag = NotAllowComment_type;
    }
    [commentBtn addTarget:self action:@selector(clickeComment:) forControlEvents:UIControlEventTouchUpInside];
    [_showToolView addSubview:commentBtn];
    //
    NSInteger likeNum_length = _model.likeNumbers.length;
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    likeBtn.frame = CGRectMake(254/2, 14, 20+likeNum_length*12, 23);
    [likeBtn setImage:[UIImage imageNamed:@"addToFavoriteBtn"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"addToFavorite_selected"] forState:UIControlStateSelected];
    [likeBtn setTitle:_model.likeNumbers forState:UIControlStateNormal];
    [likeBtn setTitle:@"收入心愿单" forState:UIControlStateSelected];
    [likeBtn setTitleColor:JMTitleGrayColor forState:UIControlStateNormal];
    likeBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    
    [likeBtn addTarget:self action:@selector(addToFavoriteClicked:) forControlEvents:UIControlEventTouchUpInside];
    NSNumber *isLike = [[NSUserDefaults standardUserDefaults] objectForKey:_model.productID];
    if (isLike == nil || isLike == NO) {
        likeBtn.selected = NO;
        [likeBtn setImage:[UIImage imageNamed:@"addToFavoriteBtn"] forState:UIControlStateHighlighted];
    }else if (isLike.boolValue == YES){
        likeBtn.selected = YES;
        CGPoint center = likeBtn.center;
        likeBtn.frame = CGRectMake(21, 12, 25+12*12, 23);
        likeBtn.center = center;
        [likeBtn setImage:[UIImage imageNamed:@"addToFavorite_selected"] forState:UIControlStateHighlighted];
    }
    [_showToolView addSubview:likeBtn];
    
    //buy
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(JMDeviceWidth-5-60, 10, 28+30, 30);
    buyBtn.backgroundColor = JMCustomBarTintColor;
    buyBtn.layer.cornerRadius = 14.0;
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [buyBtn addTarget:self action:@selector(buyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_showToolView addSubview:buyBtn];
    
    if (_model.cellHeight == 0) {
        _model.cellHeight = CGRectGetMaxY(_showToolView.frame);
    }
}
#pragma mark - button action
- (void)buyBtnClicked:(UIButton *)btn
{
    [self.delegate clickCenterWithType:BuyThisProduct_type atIndexPath:_currentIndexPath];
}
- (void)clickeComment:(UIButton *)btn
{
    if (btn.tag == AllowComment_type) {
        [self.delegate clickCenterWithType:AllowComment_type atIndexPath:self.currentIndexPath];
    }else {
        [self.delegate clickCenterWithType:NotAllowComment_type atIndexPath:_currentIndexPath];
    }
}
- (void)addToFavoriteClicked:(UIButton *)btn
{
    if (btn.selected == YES) {
        [self.delegate clickCenterWithType:MoveToOtherFavoriteList_type atIndexPath:_currentIndexPath];
    }else {
        //set up,key = productID, value =true
        [[NSUserDefaults standardUserDefaults ]setObject:@(YES) forKey:_model.productID];
        btn.selected = YES;
        CGPoint center = btn.center;
        btn.frame =  CGRectMake(21, 12, 25+12*12, 23);
        btn.center = center;
        
        CGPoint centerXY = btn.center;
        [UIView animateWithDuration:0.4 animations:^{
            btn.center = centerXY;
            btn.transform = CGAffineTransformMakeScale(1.4, 1.4);
            [UIView animateWithDuration:0.4 animations:^{
                btn.alpha = 0.0;
            } completion:^(BOOL finished) {
                btn.transform = CGAffineTransformIdentity;
                btn.alpha = 1.0;
            }];
        }];
        
        [self.delegate clickCenterWithType:LikeIt_type atIndexPath:_currentIndexPath];
    }
}
- (void)imageViewTapRecognizer:(UITapGestureRecognizer *)tap
{
    [self.delegate checkProductDetails:tap.view.tag];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(JMListDetailProductModel *)model
{
    static NSString *reuseIdentifier = @"JMListDetailCell";

    JMListDetailCell* cell = [[JMListDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[JMLabel class]] && ![view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    cell.model = model;
    cell.currentIndexPath = indexPath;
    return cell;
}
- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath
{
    _currentIndexPath = currentIndexPath;
    if (_currentIndexPath.row < 9) {
        _countLabel.text = [NSString stringWithFormat:@"0%ld",_currentIndexPath.section+1];
    }else {
        _countLabel.text = [NSString stringWithFormat:@"%ld",_currentIndexPath.section+1];
    }
}
@end
