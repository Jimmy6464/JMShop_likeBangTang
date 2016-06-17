//
//  JMProductDetailViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductDetailViewController.h"
#import "JMProductTitleView.h"
#import "JMPorductDetailTool.h"
#import "JMProductDetailModel.h"
@interface JMProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak)JMProductTitleView *titleView;
@end

@implementation JMProductDetailViewController
static CGFloat _scrollViewheight = 0;
static CGFloat _imageHeight = 250;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    //titleView
    JMProductTitleView *titleView = [[JMProductTitleView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 300)];

    JMProductDetailModel *model = [JMPorductDetailTool createProductDetailModel];
    titleView.model = model;
    titleView.autoresizesSubviews= YES;
    _titleView = titleView;
    [self.view layoutIfNeeded];
    _scrollViewheight = _titleView.height;

    //
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(titleView.height, 0, 0, 0);
    [self.view addSubview:tableView];
    _tableView = tableView;
    _titleView.y = -_titleView.height;
    [tableView addSubview:titleView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        cell.clipsToBounds = YES;
    }
    cell.textLabel.text = @"Jimmy";
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}
#pragma mark - 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%lf",y);
    if (y < -_scrollViewheight) {
        _titleView.contentOffsetY = _imageHeight + (-_scrollViewheight-y);
        CGRect frame = _titleView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _titleView.frame = frame;
    }
}
@end
