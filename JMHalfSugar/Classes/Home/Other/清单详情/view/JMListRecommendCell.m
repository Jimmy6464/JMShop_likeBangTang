//
//  JMListRecommendCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/22.
//  Copyright © 2016年 HDCircles. All rights reserved.
//
/*
 commentBtnTag = 10000
 collectBtnTag = 10001
 shareBtnTag = 10002
 */
#import "JMListRecommendCell.h"
#import "JMDrawLine.h"
#import "JMUserRecommendModel.h"
#import "JMUserRecommendProductModel.h"
#import "JMUserRecommendTagsModel.h"
#import "JMUserRecommendDynamicModel.h"
#import "JMUserRecommendPicModel.h"
#import "JMAuthor.h"
@interface JMListRecommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pciImgaeView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *tagBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *tagIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *tipButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *overLookLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
//share view
@property (weak, nonatomic) IBOutlet UIView *shareBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *platformImageView;
@property (weak, nonatomic) IBOutlet UILabel *platformLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *iconBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic, strong)JMUserRecommendModel *model;
@end
static NSIndexPath *currentIndexPath;
@implementation JMListRecommendCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"JMListRecommendCell" owner:nil options:nil]lastObject];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    
    //header
    self.authorNameLabel.textColor = JMHalfBlackTitleColor;
    self.authorNameLabel.font = [UIFont systemFontOfSize:15.0];
    
    self.createTimeLabel.textColor = JMGrayLineColor;
    self.createTimeLabel.font = [UIFont systemFontOfSize:10.0];
    //button view ,dividing line
    JMDrawLine *topLine = [JMDrawLine createLineInRect:CGRectMake(0, CGRectGetMaxY(self.likesLabel.frame)+30, JMDeviceWidth, 1.0) drawType:DottedLine];
    [self.contentView addSubview:topLine];
    [topLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.commentButton withOffset:10];
    [topLine autoSetDimensionsToSize:CGSizeMake(JMDeviceWidth, 1.0)];
    //tag view
    self.tagBackgroundView.backgroundColor = [UIColor clearColor];
    
    //share view
    self.shareBackgroundView.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
    UIControl *control = [[UIControl alloc]initWithFrame:self.shareBackgroundView.bounds];
    control.tag = 10003;
    [control addTarget:self action:@selector(clickCenter:) forControlEvents:UIControlEventTouchUpInside];
    control.backgroundColor = [UIColor clearColor];
    [self.shareBackgroundView addSubview:control];
    
    //
    self.productNameLabel.textColor = JMMainTitleColor;
    self.productNameLabel.font = [UIFont systemFontOfSize:14.0];
    self.productNameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.platformLabel.textColor = JMSubTitleColor;
    self.platformLabel.font = [UIFont systemFontOfSize:14.0];
    
    self.priceLabel.textColor = JMCustomBarTintColor;
    self.priceLabel.font = [UIFont systemFontOfSize:11.0];
    
    self.iconBackgroundView.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
    
    //like and look
    self.likesLabel.textColor = JMGrayLineColor;
    self.likesLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.overLookLabel.textColor = JMGrayLineColor;
    self.overLookLabel.font = [UIFont systemFontOfSize:13.0];
    
    JMDrawLine *bottomLine = [JMDrawLine createLineInRect:CGRectMake(0, CGRectGetMaxY(self.likesLabel.frame)+30, JMDeviceWidth, 1.0) drawType:DottedLine];
    [self.contentView addSubview:bottomLine];
    [bottomLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.likesLabel withOffset:15];
    [bottomLine autoSetDimensionsToSize:CGSizeMake(JMDeviceWidth, 1.0)];
    
    self.commentImageView.userInteractionEnabled = YES;
    [self.commentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCenter:)]];
}
#pragma mark - clicked center
- (void)clickCenter:(id)sender
{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        [self.delegate listRecommendClickCenter:AllowComment_type atIndexPath:currentIndexPath];
        return;
    }
    [self.delegate listRecommendClickCenter:BuyThisProduct_type atIndexPath:currentIndexPath];
    
}
- (IBAction)commentAction:(id)sender {
    [self.delegate listRecommendClickCenter:AllowComment_type atIndexPath:currentIndexPath];
}
- (IBAction)addToFavoriteAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.delegate listRecommendClickCenter:LikeIt_type atIndexPath:currentIndexPath];
}
- (IBAction)shareAction:(UIButton *)sender {
    [self.delegate  listRecommendClickCenter:ShareProduct_type atIndexPath:currentIndexPath];
}

- (void)tapProImageView:(UITapGestureRecognizer *)tap
{
    UIImageView * imageView = (UIImageView *)tap.view;
    JMUserRecommendPicModel *picModel = _model.picArray[0];
    
    if(picModel.tagDict[@"x"] != nil && picModel.tagDict[@"y"] != nil)
    {
        if (imageView.subviews.count>0) {
            for (UIView *view in imageView.subviews) {
                [view removeFromSuperview];
            }
        }else {
            [JMDrawLine createLineInView:BrokenLine contentView:imageView titleDict:picModel.tagDict];
        }
        
    }
}
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(JMUserRecommendModel *)model
{
    static NSString *reuseIdentifier = @"JMListRecommendCell";
    JMListRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMListRecommendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = model;
    currentIndexPath = indexPath;
    return cell;
}
- (void)setModel:(JMUserRecommendModel *)model
{
    _model = model;
    [self setUpData];
}
- (void)setUpData
{
    [self setUPHeaderPart];
    [self setUpTagPart];
    [self setUpSharePart];
    [self setLikeAndLook];
}
- (void)setUPHeaderPart
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_model.author.avatar] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    self.authorNameLabel.text = _model.author.nickname;
    
    self.createTimeLabel.text = _model.createTime;
    
    JMUserRecommendPicModel *product = _model.picArray[0];
    [self.pciImgaeView sd_setImageWithURL:[NSURL URLWithString:product.url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapProImageView:)];
    self.pciImgaeView.userInteractionEnabled = YES;
    [self.pciImgaeView addGestureRecognizer:tap];
                                          
}
- (void)setUpTagPart
{
    NSArray *tags = _model.tagArray;
    CGFloat __block orginX = CGRectGetMaxX(self.tagIconImageView.frame)+10;
    if (tags.count>0) {
        [tags enumerateObjectsUsingBlock:^(JMUserRecommendTagsModel   *tag, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *label = [[UILabel alloc]init];
            label.text = tag.name;
            label.textColor = JMCustomBarTintColor;
            label.font = [UIFont systemFontOfSize:14.0];
            [label sizeToFit];
            if (JMDeviceWidth - orginX - 10 < label.width) {
                return ;
            }
            label.frame = CGRectMake(orginX, self.tagBackgroundView.height/2, label.width, label.height);
            [self.tagBackgroundView addSubview:label];
            orginX += label.width + 5;
        }];
    }
    self.descriptionLabel.text = _model.content;
}
- (void)setUpSharePart
{
    JMUserRecommendProductModel *model = _model.productArray[0];
    [self.shareImageVIew sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.productNameLabel.text = model.title;
    
    NSString *platformImageURL;
    NSString *platformName;
    NSString *placeHolderName;
    switch (model.platform.intValue) {
        case 0:
        {
            platformImageURL = @"http://7viiaj.com2.z0.glb.qiniucdn.com/shop/taobao-order.png?v=1";
            platformName = @"来自淘宝";
            placeHolderName = @"icon_Tabbao";
            break;
        }
        case 1:
        {
            platformImageURL = @"http://7viiaj.com2.z0.glb.qiniucdn.com/shop/jd-order.png?v=1";
            platformName = @"来自京东";
            placeHolderName = @"icon_Tabbao";
            break;
        }
        case 2:
        {
            platformImageURL = @"http://7viiaj.com2.z0.glb.qiniucdn.com/shop/z-order.png?v=1";
            platformName = @"来自亚马逊";
            placeHolderName = @"icon_Tabbao";
            break;
        }
        default:
            break;
    }
    [self.platformImageView sd_setImageWithURL:[NSURL URLWithString:platformImageURL] placeholderImage:[UIImage imageNamed:placeHolderName]];
    self.platformLabel.text = platformName;
    //
    self.priceLabel.text = [NSString stringWithFormat:@"$%@软妹币",model.price];
    
}
- (void)setLikeAndLook
{
    JMUserRecommendDynamicModel *dynamic = _model.dynamic;
    self.likesLabel.text =[ NSString stringWithFormat:@"%@人喜欢吖",dynamic.likes];
    self.overLookLabel.text = [NSString stringWithFormat:@"%@人浏览",dynamic.views];
    [self.contentView layoutIfNeeded];
    if (_model.cellHeight <= 0) {
        _model.cellHeight = CGRectGetMaxY(self.commentImageView.frame)+10;
    }
}

@end
