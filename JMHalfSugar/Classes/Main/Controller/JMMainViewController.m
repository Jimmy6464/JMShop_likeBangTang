//
//  JMMainViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMMainViewController.h"
#import "JMNaviViewController.h"
#import "JMHomeViewController.h"
#import "JMMessageViewController.h"
#import "JMSquareViewController.h"
#import "JMMineViewController.h"
#import "JMAlbumViewController.h"
#import "JMTabBar.h"
@interface JMMainViewController ()<JMTabBarDelegate>
@property (nonatomic, strong) JMTabBar *customTabBar;
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation JMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initialized all subviews
- (void)initializedSubviews
{
    JMTabBar *tabBar = [[JMTabBar alloc]init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];

    _customTabBar = tabBar;
    
    //initialized all childViewController
    [self addAllChildViewController];
}
- (void)addAllChildViewController
{
    //Home
    JMHomeViewController *home = [JMHomeViewController new];
    [self setUpOneChildViewController:home title:@"" image:[UIImage imageNamed:@"Home_unselected"] selectedImage:[UIImage imageNamed:@"Home_selected"]];
    
    //Message
    JMMessageViewController *message = [JMMessageViewController new];
    [self setUpOneChildViewController:message title:@"Message" image:[UIImage imageNamed:@"Message_normal"] selectedImage:[UIImage imageNamed:@"Message_selected"]];
    
    //Square
    JMSquareViewController *square = [JMSquareViewController new];
    [self setUpOneChildViewController:square title:@"Square" image:[UIImage imageNamed:@"Square_normal"] selectedImage:[UIImage imageNamed:@"Square_selected"]];
    
    //Mine
    JMMineViewController *mine = [JMMineViewController new];
    [self setUpOneChildViewController:mine title:@"Mine" image:[UIImage imageNamed:@"PersonCenter_unlogin"] selectedImage:[UIImage imageNamed:@"PersonCenter_normal_login"]];
}
- (void)setUpOneChildViewController:(UIViewController *)viewController title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    viewController.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;

    [self addChildViewController:[[JMNaviViewController alloc] initWithRootViewController:viewController]];
    [self.customTabBar addTabBarButtomWithItem:viewController.tabBarItem];
}
#pragma mark - JMTabBarDelegate
- (void)tabBar:(JMTabBar *)tabBar didSelectedAtindex:(NSInteger)selectedIndex
{
    if (selectedIndex == 0 && selectedIndex == _selectIndex) {
        //refresh
        
    }
    self.selectedIndex = selectedIndex;
    _selectIndex = selectedIndex;
}
- (void)tabBarDidClickAddBtn:(JMTabBar *)tabBar
{
    //add button clicked
    [self presentViewController:[[JMNaviViewController alloc] initWithRootViewController:[JMAlbumViewController new]] animated:YES completion:nil];
}
@end
