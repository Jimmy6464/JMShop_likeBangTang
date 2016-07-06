//
//  JMPlantGrassCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/29.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPlantGrassCell.h"
#import "JMPlantGrassTeamModel.h"
@interface JMPlantGrassCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *teamNameLabel;
@property (nonatomic, weak) UILabel *teamParameterLabel;
@property (nonatomic, strong)JMPlantGrassTeamModel *model;
@end
@implementation JMPlantGrassCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andModel:(JMPlantGrassTeamModel *)model
{
    static NSString *reuseIdentifier = @"JMPlantGrassCell";
    JMPlantGrassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (void)setModel:(JMPlantGrassTeamModel *)model
{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.pic2] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    //
    self.teamNameLabel.text = _model.teamName;
    [self.teamNameLabel sizeToFit];
    self.teamNameLabel.y = 25;
    self.teamNameLabel.centerX = self.width/2;
    //
    self.teamParameterLabel.text = [NSString stringWithFormat:@"%ld浏览  %ld帖子",_model.lookCount,_model.likeCount];
    [self.teamParameterLabel sizeToFit];
    self.teamParameterLabel.y = CGRectGetMaxY(self.teamNameLabel.frame)+5;
    self.teamParameterLabel.centerX = self.width/2;
}
- (void)initializedSubviews
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:imageView];
    _imgView = imageView;
    
    //
    UILabel *teamNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    teamNameLabel.textAlignment = NSTextAlignmentCenter;
    teamNameLabel.layer.zPosition = 2.0;
    teamNameLabel.layer.cornerRadius = 3.0;
    teamNameLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    teamNameLabel.layer.borderWidth = 0.5;
    teamNameLabel.font = [UIFont fontWithName:LightFont size:15.0];
    teamNameLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:teamNameLabel];
    self.teamNameLabel = teamNameLabel;
    //
    UILabel *teamParmeterLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    teamParmeterLabel.textAlignment = NSTextAlignmentCenter;
    teamParmeterLabel.textColor = [UIColor whiteColor];
    teamParmeterLabel.font = [UIFont fontWithName:LightFont size:12.0];
    [self.contentView addSubview:teamParmeterLabel];
    self.teamParameterLabel = teamParmeterLabel;
}
@end
