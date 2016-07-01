//
//  JMTabBarButton.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMTabBarButton.h"
#import "JMBadgeView.h"
#define JMImageRadius 0.7
#define JMBouundary 6
@interface JMTabBarButton  ()
@property (nonatomic, weak) JMBadgeView *badgeView;
@end
@implementation JMTabBarButton
#pragma mark - forecated loading
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}
- (JMBadgeView *)badgeView
{
    if (!_badgeView) {
        JMBadgeView *badgeView = [JMBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:badgeView];
        _badgeView = badgeView;
    }
    return _badgeView;
}

#pragma mark - override 'setItem' method and observe the item
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
//    [self setTitle:item.title forState:UIControlStateNormal];
    self.badgeView.badgeValue = item.badgeValue;
    
    [_item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
//    [_item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.badgeView.badgeValue = _item.badgeValue;
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
//    [self setTitle:_item.title forState:UIControlStateNormal];
}
- (void)dealloc
{
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
//    [_item removeObserver:self forKeyPath:@"title"];
}

#pragma mark - override 'layoutSubviews' method
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.width;
    CGFloat btnH = self.height;
    CGFloat imageH = btnH * JMImageRadius;
    self.imageView.frame = CGRectMake(0, 5, btnW, imageH);
    self.imageView.centerY =  self.centerY;
//    self.imageView.center = self.center;
//    CGFloat titleH = btnH - imageH;
//    CGFloat titleY = imageH - 2;
//    self.titleLabel.frame = CGRectMake(0, titleY, btnW, titleH);
    self.badgeView.x = self.width - self.badgeView.width - JMBouundary;
    self.badgeView.y = 0;
}
@end
