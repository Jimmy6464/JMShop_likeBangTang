//
//  JMSignInCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/7/6.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSignInCell.h"

@interface JMSignInCell ()
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@end
@implementation JMSignInCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.firstLabel.text = @"连续签到1天";
    self.firstLabel.textColor = JMMainTitleColor;
    self.firstLabel.font = [UIFont fontWithName:LightFont size:16.0];
    
    self.secondLabel.text = @"连续签到明天可获得额外的10分奖励";
    self.secondLabel.textColor = JMSubTitleColor;
    self.secondLabel.font = [UIFont fontWithName:LightFont size:14.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
