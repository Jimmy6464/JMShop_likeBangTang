//
//  JMListDetailViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/21.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailViewController.h"
#import "JMListHeaderView.h"
#import "JMListModel.h"
@interface JMListDetailViewController ()
@property (nonatomic, weak) JMListHeaderView *headerview;
@property (nonatomic, strong) JMListModel *listModel;
@property (nonatomic, strong) UIImage *image;
@end

@implementation JMListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    JMListHeaderView *headerView = [[JMListHeaderView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 0) withTitle:_listModel.title subTitle:_listModel.detailText andImage:_image];
}
- (void)buildSegmentView
{
    
}

@end
