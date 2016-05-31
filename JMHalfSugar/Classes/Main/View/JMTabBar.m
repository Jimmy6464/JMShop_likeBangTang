//
//  JMTabBar.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMTabBar.h"
#import "JMTabBarButton.h"
@interface JMTabBar ()
@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, strong) UIButton *selectedButton;
@end
@implementation JMTabBar
#pragma mark - forecasted loading
- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}
- (UIButton *)addButton
{
    if (_addButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        [button setImage:[UIImage imageNamed:@"Show_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Show_normal"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickedAddButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _addButton = button;
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
    JMTabBarButton *button = [JMTabBarButton buttonWithType:UIButtonTypeCustom];
    button.item = item;
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    button.tag = self.tabBarButtons.count;
    if (self.tabBarButtons.count == 0) {
        [self btnClick:button];
    }

    [self addSubview:button];
    [self.tabBarButtons addObject:button];
}
#pragma mark - observing button
- (void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedAtindex:)]) {
        [_delegate tabBar:self didSelectedAtindex:button.tag];
    }
}


#pragma mark - override 'layoutSubviews' method to set up subviews's frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpTabBarButtonsFrame];
    [self setUpAddButtonFrame];
}
- (void)setUpAddButtonFrame
{
    CGFloat centerX = self.width * 0.5;
    CGFloat centerY = self.height * 0.5;
    
    self.addButton.size = CGSizeMake(45, 45);
    self.addButton.center = CGPointMake(centerX, centerY);
}
- (void)setUpTabBarButtonsFrame
{
    NSInteger i = 0 ;
    NSInteger count = self.tabBarButtons.count + 1;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    for (UIView *tabBarButton in self.tabBarButtons) {
        if (i == 2) {
            i += 1;
        }
        tabBarButton.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        i++;
    }
//    [self.tabBarButtons enumerateObjectsUsingBlock:^(UIView* tabBarButton, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (idx == 2) {
//            idx++;
//        }
//        tabBarButton.frame = CGRectMake(idx * btnW, 0, btnW, btnH);
//    }];
}
@end
