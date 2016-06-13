//
//  JMHomeViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMHomeViewController.h"
#import "JMBannerView.h"
#import "JMTitleScrollView.h"
#import "JMHomeProductCell.h"
#import "JMProductRecommend.h"
@interface JMHomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMBannerViewDelegate,JMTitleScrollViewDelegate>
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)JMBannerView *bannerView;
@property (nonatomic, weak)JMTitleScrollView *titleScrollView;
@property (nonatomic, strong)NSMutableArray *productArray;
@property (nonatomic, strong)NSMutableArray *bannerArray;
@end

@implementation JMHomeViewController
static NSInteger _titleIndex = 0;
- (NSMutableArray *)bannerArray
{
    if (!_bannerArray) {
        _bannerArray = [[JMProductRecommend alloc] createDailyBannerModel];
    }
    return _bannerArray;
}
- (NSMutableArray *)productArray
{
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- load data
- (void)loadData
{
    self.productArray = [[JMProductRecommend alloc] createProductRecommendModelAtCategoryIndex:0];
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    JMBannerView *bannerView = [[JMBannerView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 257)];
    bannerView.bannerArray = self.bannerArray;
    bannerView.delegate = self;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = bannerView;
    [self.view addSubview:tableView];
    _tableView = tableView;
    _bannerView = bannerView;
    
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMHomeProductCell *cell = [JMHomeProductCell cellWithTableView:tableView];
    return cell;
}
#pragma mark - 
- (void)tableView:(UITableView *)tableView willDisplayCell:(JMHomeProductCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = self.productArray[indexPath.row];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = @[@"最新",@"文艺",@"礼物",@"指南",@"爱美",@"设计",@"吃货",@"厨房",@"上班",@"学生",@"聚会",@"节日",@"宿舍"];
    JMTitleScrollView *titleScrollView = [[JMTitleScrollView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 36.0) titleArray:array fontSize:16.0 _textLength:2.0 andButtonSpacing:30.0];
    titleScrollView.delegate = self;
    titleScrollView.tDelegate = self;
    titleScrollView.contentSize = CGSizeMake(array.count*2*16+(array.count-1)*30+24, 36.0);
    [titleScrollView setBottomViewAtIndex:_titleIndex];
    _titleScrollView = titleScrollView;
    return _titleScrollView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 188;
}
#pragma mark - JMBannerViewDelegate
- (void)bannerButtonClickeWithType:(enum ClickType)clickType
{
    switch (clickType) {
        case GoodThingClickType:
            NSLog(@"goodthing");
            break;
        case SearchClickType:
            NSLog(@"search");
            break;
            
        case PlantGrassClickType:
            NSLog(@"plant");
            break;
            
        case SignInClickType:
            NSLog(@"signIn");
            break;
            
        default:
            break;
    }
}
#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index
{
    self.productArray = [[JMProductRecommend alloc] createProductRecommendModelAtCategoryIndex:index];
    [self.tableView reloadData];
    _titleIndex = index;
}
@end
