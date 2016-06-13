//
//  JMNaviViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/31.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMNaviViewController.h"
#import "JMTabBar.h"
#import "UIColor+Hex.h"
@interface JMNaviViewController ()<UINavigationControllerDelegate>

@end

@implementation JMNaviViewController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {

        self.navigationBar.translucent = NO;
        self.navigationBar.barTintColor = [UIColor colorWithHexString:@"EC5252"];
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate =self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[JMTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }else {
            NSLog(@"others");
        }
    }
    
}
@end
