//
//  JMScoreCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/7/6.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMScoreCell.h"

@interface JMScoreCell ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@end
@implementation JMScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.font = [UIFont fontWithName:LightFont size:15.0];
            label.textColor = JMSubTitleColor;
        }
    }
    self.scoreLabel.textColor = JMCustomBarTintColor;
    self.scoreLabel.text = @"10";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
