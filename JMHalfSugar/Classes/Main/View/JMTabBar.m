//
//  JMTabBar.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMTabBar.h"

@interface JMTabBar ()
@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, strong) UIButton *selectedButton;
@end
@implementation JMTabBar
#pragma mark - forecasted loading
- (NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
#warning need add the image;
        [button setImage:nil forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickedAddButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return _addButton;
}
- (void)clickedAddButton
{
    if ([_delegate respondsToSelector:@selector(tabBarDidClickAddBtn:)]) {
        [_delegate tabBarDidClickAddBtn:self];
    }
}

#pragma mark - public method
- (void)addTabBarButtomWithItem:(UITabBarItem *)item
{
    
}
@end
