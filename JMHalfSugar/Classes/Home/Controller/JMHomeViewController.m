//
//  JMHomeViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMHomeViewController.h"
#import "JMSearchViewController.h"
#import "JMListDetailViewController.h"
#import "JMBannerView.h"
#import "JMTitleScrollView.h"
#import "JMHomeProductCell.h"
#import "JMProductRecommend.h"
#import "JMProductRecommendModel.h"
@interface JMHomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMBannerViewDelegate,JMTitleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)JMBannerView *bannerView;
@property (nonatomic, weak)UIView *headerView;
@property (nonatomic, weak)UICollectionView *collectionView;
@property (nonatomic, weak)JMTitleScrollView *titleScrollView;
@property (nonatomic, strong)NSMutableArray *productArray;
@property (nonatomic, strong)NSMutableArray *bannerArray;
@property (nonatomic, strong)NSMutableArray *categoryArray;
@end

@implementation JMHomeViewController
static NSInteger _titleIndex = 0;
static CGFloat _currentContentOffSetX = 0.0f;
- (NSMutableArray *)categoryArray
{
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray arrayWithArray:@[@"最新",@"文艺",@"礼物",@"指南",@"爱美",@"设计",@"吃货",@"厨房",@"上班",@"学生",@"聚会",@"节日",@"宿舍"]];
    }
    return _categoryArray;
}
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
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 257+36)];
    [self.view addSubview:view];
    _headerView = view;
    
    JMBannerView *bannerView = [[JMBannerView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 257)];
    bannerView.bannerArray = self.bannerArray;
    bannerView.delegate = self;
    [self.headerView addSubview:bannerView];
    _bannerView = bannerView;


    JMTitleScrollView *titleScrollView = [[JMTitleScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bannerView.frame), JMDeviceWidth, 36.0) titleArray:self.categoryArray fontSize:16.0 _textLength:2.0 andButtonSpacing:30.0];
    titleScrollView.delegate = self;
    titleScrollView.tDelegate = self;
    titleScrollView.contentSize = CGSizeMake(_categoryArray.count*2*16+(_categoryArray.count-1)*30+24, 36.0);
    [titleScrollView setBottomViewAtIndex:_titleIndex];
    [self.headerView addSubview:titleScrollView];
    _titleScrollView = titleScrollView;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.minimumLineSpacing = 0.0f;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), JMDeviceWidth, JMDeviceHeight) collectionViewLayout:flowLayout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    collectionView.contentSize = CGSizeMake(_bannerArray.count*JMDeviceWidth, 0);
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithTitle:@"search" style:UIBarButtonItemStyleDone target:self action:@selector(showSearching)];
    self.navigationItem.leftBarButtonItem = searchItem;
}
- (void)showSearching
{
    JMSearchViewController *search = [JMSearchViewController new];
    [search setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:search animated:YES];
}
#pragma makr -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.productArray = [[JMProductRecommend alloc] createProductRecommendModelAtCategoryIndex:section];
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _categoryArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            [view removeFromSuperview];
        }
    }
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 64+84, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView reloadData];
    _titleIndex = indexPath.section;
    [cell.contentView addSubview:tableView];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JMDeviceWidth, JMDeviceHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
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
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(JMHomeProductCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.productArray = [[JMProductRecommend alloc] createProductRecommendModelAtCategoryIndex:_titleIndex];
    cell.model = self.productArray[indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 188;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMHomeProductCell *cell =(JMHomeProductCell *) [tableView cellForRowAtIndexPath:indexPath];
    JMProductRecommendModel *model = self.productArray[indexPath.row];
    JMListDetailViewController *list = [JMListDetailViewController new];
    list.image = cell.imageV.image;
    list.listID = model.productID;
    [list setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        NSInteger x =_collectionView.contentOffset.x;
        
        if (( x% (NSInteger)JMDeviceWidth )== 0) {
            _titleIndex = _collectionView.contentOffset.x/JMDeviceWidth;
            [_titleScrollView setBottomViewAtIndex:_titleIndex];
        }
        _currentContentOffSetX = _collectionView.contentOffset.x;
        
    }else {
//        if (_headerView.y >= 0) {
//            [UIView animateWithDuration:0.3 animations:^{
//                [self.navigationController setNavigationBarHidden:NO animated:YES];
//                
//                _headerView.y = _headerView.y - _bannerView.height;
//                _collectionView.y = CGRectGetMaxY(_headerView.frame);
//            }];
//            
//        }
//        return;
        
        if (_headerView.y == -257+64) {
            //make the naviBar to be tranclent;
            self.navigationController.navigationBar.alpha = 1.0f;
        }else{
            //show the Bar;
            self.navigationController.navigationBar.alpha = 0.0f;
        }
        if (_headerView.y > -257+64 && scrollView.contentOffset.y > 0) {
            if (scrollView.contentOffset.y /43.0 < 1.0) {
                //change th bar.alpha
                self.navigationController.navigationBar.alpha = scrollView.contentOffset.y/43.0;
            }
            _collectionView.frame = CGRectMake(0, _collectionView.y-scrollView.contentOffset.y, JMDeviceWidth, JMDeviceHeight);
            _headerView.center = CGPointMake(JMDeviceWidth/2, _headerView.y-scrollView.contentOffset.y);
            if (_headerView.y < -257+64) {
                _headerView.frame = CGRectMake(0, -257+64, JMDeviceWidth, 293);
                _collectionView.frame = CGRectMake(0, 64+36, JMDeviceWidth, JMDeviceHeight);
            }
        }else if (_headerView.y <= 0 && _collectionView.y <= 293 && scrollView.contentOffset.y < 0){
            if (-scrollView.y/43.0 < 1.0 && _headerView.y< 0) {
                //change the bar.alpha
                self.navigationController.navigationBar.alpha = -scrollView.contentOffset.y/43.0;
            }
            _collectionView.center = CGPointMake(_collectionView.centerX, _collectionView.centerY-scrollView.contentOffset.y);
            _headerView.center = CGPointMake(JMDeviceWidth/2, _headerView.centerY-scrollView.contentOffset.y);
            if (_headerView.frame.origin.y > 0) {
                _headerView.frame = CGRectMake(0, 0, JMDeviceWidth, 293);
                _collectionView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), JMDeviceWidth, JMDeviceHeight);
                self.navigationController.navigationBar.alpha = 0.0;
            }
        }
    }
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
    
//    [self.tableView reloadData];

    _titleIndex = index;
    __weak JMHomeViewController *weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.collectionView.contentOffset = CGPointMake(index*JMDeviceWidth, 0);
    }];
    
}
@end
