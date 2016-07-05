//
//  JMSearchViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchViewController.h"
#import "JMSingleGoodsViewController.h"
#import "SDImageCache.h"
#import "JMSegmentView.h"
#import "JMInventoryView.h"
#import "JMSearchTool.h"
#import "JMSearchModel.h"
#import "JMSerchLishModel.h"
#import "JMSearchListCell.h"

@interface JMSearchViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JMSegmentViewDelegate,JMINventoryViewDelegate>
@property (nonatomic, weak)UISearchBar *searchBar;
@property (nonatomic, weak)UIView *naviBgView;
@property (nonatomic, weak)JMSegmentView *segmentView;
@property (nonatomic, weak)JMInventoryView *inventoryView;
@property (nonatomic, weak)UIScrollView *mainScrollView;
@property (nonatomic, weak)UICollectionView *showCollectionView;
@property (nonatomic, strong)NSMutableArray<JMSearchModel *> *searchSingleModels;
@property (nonatomic, strong)NSMutableArray<JMSearchModel *> *subSearchModels;
@property (nonatomic, strong)NSMutableArray<JMSerchLishModel *> *searchListModels;
@end

@implementation JMSearchViewController
- (NSMutableArray<JMSerchLishModel *> *)searchListModels
{
    if (!_searchListModels) {
        _searchListModels = [NSMutableArray array];
    }
    return _searchListModels;
}
- (NSMutableArray<JMSearchModel *> *)searchSingleModels
{
    if (!_searchSingleModels) {
        _searchSingleModels = [NSMutableArray array];
    }
    return _searchSingleModels;
}
- (NSMutableArray<JMSearchModel *> *)subSearchModels
{
    if (!_subSearchModels) {
        _subSearchModels = [NSMutableArray array];
    }
    return _subSearchModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initializedSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[SDImageCache alloc] clearDisk];
}
#pragma mark - loading data
- (void)loadData
{
    self.searchSingleModels = [JMSearchTool createSearchModel];
    self.subSearchModels = _searchSingleModels[0].subList;
    self.searchListModels = [JMSearchTool createSearchListModel];
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    [self createCustomNavgationBar];
    /*//
     UISearchBar *searchBar  = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 0, JMDeviceWidth-60, 44)];
     searchBar.layer.cornerRadius = 20.0f;
     for (UIView *view in searchBar.subviews) {
     if ([view isKindOfClass:[UITextField class]]) {
     view.layer.cornerRadius = 20.0f;
     }
     }
     [searchBar setTintColor:[UIColor whiteColor]];
     searchBar.delegate = self;
     searchBar.placeholder = @"搜索单品、清单、帖子、用户";
     [searchBar setPositionAdjustment:UIOffsetMake(30, 0) forSearchBarIcon:UISearchBarIconSearch];
     [self.navigationController.navigationBar insertSubview:searchBar aboveSubview:self.navigationController.navigationBar];
     _searchBar = searchBar;*/
    //
    JMSegmentView *segmentView =[[JMSegmentView alloc]initWithFrame:CGRectMake(0, _naviBgView.height, JMDeviceWidth, 44) firstTitle:@"清单" secondTitle:@"单品"];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    _segmentView = segmentView;
    
    //
    JMInventoryView *inventoryView = [[JMInventoryView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight-CGRectGetMaxY(_segmentView.frame))];
    inventoryView.categoryModel = self.searchSingleModels;
    inventoryView.delegate = self;
    [self.view addSubview:inventoryView];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.minimumInteritemSpacing = 20.0f;
    flowLayout.minimumLineSpacing = 20.0f;
    
    CGFloat cHeight = JMDeviceWidth- CGRectGetMaxY(_segmentView.frame);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(JMDeviceWidth, 0, JMDeviceWidth, JMDeviceHeight) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.contentSize = CGSizeMake(0, cHeight);
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[JMSearchListCell class] forCellWithReuseIdentifier:@"ListCell"];

    //
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentView.frame), JMDeviceWidth, JMDeviceHeight-CGRectGetMaxY(_segmentView.frame))];
    mainScrollView.showsHorizontalScrollIndicator = false;
    mainScrollView.bounces = NO;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.delegate = self;
    mainScrollView.contentSize = CGSizeMake(JMDeviceWidth*2, cHeight);
    [self.view addSubview:mainScrollView];
    [mainScrollView addSubview:inventoryView];
    [mainScrollView addSubview:collectionView];
    _mainScrollView = mainScrollView;
}
- (void)createCustomNavgationBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 64)];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 0, 28, 28);
    backBtn.centerY = 42;
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"mobile-back"] forState:UIControlStateNormal];
    [navBar addSubview:backBtn];
    
    CGFloat searhBarWidth = JMDeviceWidth-backBtn.width-15*2-10;
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(backBtn.width+15+10, 0, searhBarWidth, 44)];
    searchBar.centerY = 42;
    searchBar.delegate  = self;
    searchBar.searchBarStyle =UISearchBarStyleMinimal;
    searchBar.tintColor = [UIColor redColor];
    searchBar.placeholder = @"searching your favorite product";
    [navBar addSubview:searchBar];
    for (UIView *view in searchBar.subviews) {
        for (UIView *subView in view.subviews) {
            if ([subView isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subView;
                textField.clipsToBounds = YES;
                textField.layer.cornerRadius = 25/2;
            }
        }
    }
    _searchBar = searchBar;
    [self.view addSubview:navBar];
    _naviBgView = navBar;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchListModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMSearchListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
    cell.searchListModel = self.searchListModels[indexPath.row];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 25, 15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 100);
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicked");
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScrollView) {
        _segmentView.currentIndex = scrollView.contentOffset.x/JMDeviceWidth;
    }
}
#pragma mark - JMINventoryViewDelegate
- (void)didSelectedItem:(NSIndexPath *)indexPath
{
    JMSingleGoodsViewController *singleGoods = [[JMSingleGoodsViewController alloc]init];
    
    [self.navigationController pushViewController:singleGoods animated:YES];
}
#pragma mark - JMSegmentViewDelegate
- (void)clickSegmentViewAtIndex:(NSInteger)index
{
    NSLog(@"index_%ld",index);
    [_mainScrollView setContentOffset:CGPointMake((index-1)*JMDeviceWidth, 0) animated:YES];
}
@end
