//
//  JMSquareViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSquareViewController.h"
#import "JMSearchViewController.h"
#import "JMTitleScrollView.h"
#import "JMSegmentView.h"
#import "JMSquareCategoryCell.h"
#import "JMSearchListCell.h"
#import "JMPlantGrassCell.h"
#import "JMPlantTree.h"
#import "JMPlantGrassTeamModel.h"

#import "JMSquareTool.h"
#import "JMSquareModel.h"
#import "JMSerchLishModel.h"
@interface JMSquareViewController ()<JMTitleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JMSegmentViewDelegate>
@property (nonatomic, weak)UICollectionView *showCollectionView;
@property (nonatomic, weak)JMSegmentView *segmentView;
@property (nonatomic, weak)UICollectionView *categoryCollectionView;
@property (nonatomic, strong)NSMutableArray *teamModels;
@property (nonatomic, strong)NSMutableArray *cateGoryModels;
@property (nonatomic, strong)NSArray *elements;
@end

@implementation JMSquareViewController
- (NSMutableArray *)cateGoryModels
{
    if (!_cateGoryModels) {
        _cateGoryModels = [NSMutableArray array];
    }
    return _cateGoryModels;
}
- (NSMutableArray *)teamModels
{
    if (!_teamModels) {
        _teamModels = [NSMutableArray new];
    }
    return _teamModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initializedSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"EC5252"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - load data
- (void)loadData
{
    [self.teamModels addObjectsFromArray:[JMPlantTree readTeamData]];
    [self.cateGoryModels addObjectsFromArray:[JMSquareTool createSearchListModel]];
    JMSquareModel *squareM = self.cateGoryModels[0];
    self.elements  = squareM.elements;
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    [self setUpNavigationBar];
    //titleview
    CGFloat margin = (JMDeviceWidth - 24 - 4 * 15 * 4) / 3;
    JMTitleScrollView *titleScrollView = [[JMTitleScrollView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 45) titleArray:@[@"热门推荐",@"深夜食堂",@"变美神器",@"一种生活"] fontSize:15.0f _textLength:4.0f andButtonSpacing:margin];
    titleScrollView.tDelegate = self;
    [self.view addSubview:titleScrollView];
    
    //UICollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 30;
    layout.minimumLineSpacing = 30;
    
    UICollectionView *collectioView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 450/2) collectionViewLayout:layout];

    collectioView.backgroundColor = [UIColor whiteColor];
    collectioView.scrollEnabled = false;
    [collectioView registerClass:[JMSearchListCell class] forCellWithReuseIdentifier:@"JMSearchListCell"];
    collectioView.delegate = self;
    collectioView.dataSource = self;
    _showCollectionView = collectioView;
    
    //
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc]init];
    layout2.headerReferenceSize = CGSizeMake(JMDeviceWidth, 450/2+45);
    layout2.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout2.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout2.minimumInteritemSpacing = 10;
    layout2.minimumLineSpacing = 10;
    
    UICollectionView *catergoryCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, JMDeviceWidth, JMDeviceHeight-64-49-45) collectionViewLayout:layout2];
    catergoryCollectionView.backgroundColor = [UIColor whiteColor];
    [catergoryCollectionView registerClass:[JMPlantGrassCell class] forCellWithReuseIdentifier:@"JMPlantGrassCell"];
    [catergoryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionViewHeaderView"];
    catergoryCollectionView.delegate =self;
    catergoryCollectionView.dataSource = self;
    [self.view addSubview:catergoryCollectionView];
    _categoryCollectionView = catergoryCollectionView;
}
- (void)setUpNavigationBar
{
    UIBarButtonItem *searchBtn  = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"searchBtn"] style:UIBarButtonItemStyleDone target:self action:@selector(clickSearchBarButtonItem)];
    self.navigationItem.leftBarButtonItem = searchBtn;
    
    UIBarButtonItem *addFriend = [[UIBarButtonItem alloc]initWithTitle:@"friends" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = addFriend;
    
    JMSegmentView *segmentView = [[JMSegmentView alloc]initWithFrame:CGRectMake(0, 0, 184/2, 44) firstTitle:@"广场" secondTitle:@"关注"];
    segmentView.delegate = self;
    segmentView.showMidelSeparator= NO;
    segmentView.showIndicator = YES;
    segmentView.showTopBottomSeparator = YES;
    segmentView.normalColor = [UIColor lightGrayColor];
    segmentView.highlightColor = [UIColor colorWithHexString:@"EC5252"];
    segmentView.currentIndex = 0;
    self.navigationItem.titleView = [UIView new];
    self.navigationItem.titleView = segmentView;
    self.segmentView = segmentView;
}
#pragma mark - barbuttonItem event
- (void)clickSearchBarButtonItem
{
    [self.navigationController pushViewController:[JMSearchViewController new] animated:YES];
}
#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index
{
    NSLog(@"clicked index:%ld",index);
    JMSquareModel *model = self.cateGoryModels[index];
    self.elements = model.elements;
    [self.showCollectionView reloadData];
}
- (void)clickSegmentViewAtIndex:(NSInteger)index
{
    NSLog(@"Square");
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _showCollectionView) {
        return 8;
    }else {
        if (self.teamModels != nil && self.teamModels.count>0) {
            return self.teamModels.count;
        }else {
            return 0;
        }
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.showCollectionView) {
        JMSearchListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JMSearchListCell" forIndexPath:indexPath];
        cell.searchListModel = self.elements[indexPath.item];
        [cell setImageToCircle];
        return cell;
    }else {
        JMPlantGrassCell *cell = [JMPlantGrassCell cellWithCollectionView:collectionView atIndexPath:indexPath andModel:self.teamModels[indexPath.item]];
        return cell;
    }
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _showCollectionView) {
        return CGSizeMake(50, 170/2);
    }else {
        return CGSizeMake(JMDeviceHeight-30, 228/2);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView == _showCollectionView) {
        return UIEdgeInsetsMake(15, 15, 20, 15);
    }
    return UIEdgeInsetsMake(8, 0, 8, 0);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.contentOffset.y > 0) {
        cell.alpha = 0.0;
        [UIView animateWithDuration:0.4 animations:^{
            cell.alpha = 1.0;
        }];
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusaBleView ;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionViewHeaderView" forIndexPath:indexPath];
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 450/2, JMDeviceWidth, 45)];
        tipLabel.text = @"";
        tipLabel.font = [UIFont fontWithName:LightFont size:15.0];
        tipLabel.textColor = JMMainTitleColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:tipLabel];
        [headerView addSubview:self.showCollectionView];
        reusaBleView = headerView;
    }
    return reusaBleView;
}
@end
