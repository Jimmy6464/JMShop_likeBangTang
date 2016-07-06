//
//  JMTabBar.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMTabBar;
@protocol JMTabBarDelegate <NSObject>

- (void)tabBar:(JMTabBar *)tabBar didSelectedAtindex:(NSInteger)selectedIndex;
- (void)tabBarDidClickAddBtn:(JMTabBar *)tabBar;

@end
@interface JMTabBar : UIView
@property (nonatomic, weak) id<JMTabBarDelegate> delegate;
-(void)addTabBarButtomWithItem:(UITabBarItem *)item;
@end
