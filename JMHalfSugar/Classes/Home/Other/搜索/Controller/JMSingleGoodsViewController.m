//
//  JMSingleGoodsViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSingleGoodsViewController.h"
#import "JMProductDetailViewController.h"
#import "JMSingleCell.h"
#import "JMSearchTool.h"
#import "JMSearchSingleGoodsModel.h"
@interface JMSingleGoodsViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *singleModels;
@end

@implementation JMSingleGoodsViewController
- (NSMutableArray *)singleModels
{
    if (!_singleModels) {
        _singleModels = [NSMutableArray array];
    }
    return _singleModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initializedSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - loadData
- (void)loadData
{
    [self.singleModels  addObjectsFromArray:[JMSearchTool createSearchSingleGoodsModel]];
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    self.title = @"底装";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 10.0f;
    flowLayout.minimumLineSpacing = 10.0f;
    
    //
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.contentSize = CGSizeMake(JMDeviceWidth, JMDeviceHeight);
    [collectionView registerNib:[UINib nibWithNibName:@"JMSingleCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"JMSingle"];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 28, 28);
    [btn setImage:[UIImage imageNamed:@"mobile-back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)backAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.singleModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JMSingle" forIndexPath:indexPath];
    cell.model = self.singleModels[indexPath.row];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JMDeviceWidth/2-40, JMDeviceWidth/2+60);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        JMSearchSingleGoodsModel *model = self.singleModels[indexPath.item];
        JMProductDetailViewController *product = [JMProductDetailViewController new];
        product.productID = model.productID;
        [self.navigationController pushViewController:product animated:YES];
    }else {
        [UIAlertController showAlertTips:@"没有抓取数据" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0 compeletion:nil];
    }
}
@end
