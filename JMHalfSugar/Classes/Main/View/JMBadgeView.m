//
//  JMBadgeView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMBadgeView.h"
#define JMBadgeTitleFont [UIFont systemFontOfSize:11]
@implementation JMBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *backgroundImage = [UIImage imageNamed:@"main_badge"];
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];

        self.titleLabel.font = JMBadgeTitleFont;
        self.size =  backgroundImage.size;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    if (!badgeValue || [badgeValue isEqualToString:@""] || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
        return;
    }else {
        self.hidden = NO;
    }
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    CGFloat titleW = [badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:JMBadgeTitleFont} context:nil].size.width;
    if (titleW > self.width) {
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
    }else {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}
@end
