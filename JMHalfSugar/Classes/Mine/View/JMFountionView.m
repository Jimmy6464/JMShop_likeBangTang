//
//  JMFountionView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMFountionView.h"
enum FourButtonType: NSUInteger{
    OrderButtonClick = 110,
    FriedButtonClick = 111,
    PointBUttonClick = 112,
    TeamButtonClick  = 113
};
@interface JMFountionView ()

@property (nonatomic, weak)UIButton *orderBtn;
@property (nonatomic, weak)UIButton *friendBtn;
@property (nonatomic, weak)UIButton *pointBtn;
@property (nonatomic, weak)UIButton *teamBtn;
@end
@implementation JMFountionView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubview];
    }
    return self;
}
- (void)initializedSubview
{
    CGFloat orginX = 112/5;
    //margin
    CGFloat margin = (JMDeviceWidth - orginX*2-4*54)/3;

    NSArray *imageArray = @[@"button_order",@"button_friend",@"button_point",@"button-_team"];
    //UIButton
    for (NSInteger i = 0; i<imageArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+i;
        btn.frame = CGRectMake(orginX, 18, 52, 80);
        [btn addTarget:self action:@selector(clickedCenter:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateHighlighted];
        [self addSubview:btn];
        orginX += 52+ margin;
    }
    
}
#pragma mark - clicked center
- (void)clickedCenter:(UIButton *)btn
{
    if (buttonClicked != nil) {
        buttonClicked(btn.tag);
    }
}


@end
