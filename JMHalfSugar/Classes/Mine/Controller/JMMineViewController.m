//
//  JMMineViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMMineViewController.h"
#import "JMPersonCenterHeaderImageView.h"
#import "JMAlbumViewController.h"
#import "JMTitleScrollView.h"

#import "JMSearchTool.h"
#import "JMSearchSingleGoodsModel.h"
#import "JMUserRecommendTool.h"
#import "JMUserRecommendModel.h"
#import "JMProductRecommend.h"

enum ShowCollectionViewType {
    /// 单品
    SingleMode,
    /// 清单
    ListMode,
    /// 互动
    ActivityMode,
    /// 发布
    PublishMode
};
@interface JMMineViewController ()
@property (nonatomic, weak)JMPersonCenterHeaderImageView *topView;
@property (nonatomic, weak)UIImageView *headerImageView;
@property (nonatomic, weak)JMTitleScrollView *titleView;
@property (nonatomic, weak)UIImageView *backImageView;
@property (nonatomic, weak)UIView *collectionHeadView;
@property (nonatomic, weak)UICollectionView *showCollectionView;
@property (nonatomic, assign)enum ShowCollectionViewType collectionViewType;

@property (nonatomic, strong)NSMutableArray *singleList;//SearchSingleGoodsModel
@property (nonatomic, strong)NSMutableArray *listArray;
@property (nonatomic, strong)NSMutableArray *interationArray;//UserREcommendModel


@end

@implementation JMMineViewController
#pragma mark - forcasted loading
- (NSMutableArray *)singleList
{
    if (!_singleList) {
        _singleList = [NSMutableArray array];
    }
    return _singleList;
}
- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
    
}
- (NSMutableArray *)interationArray
{
    if (!_interationArray) {
        _interationArray = [NSMutableArray array];
    }
    return _interationArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initializedSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - load data
- (void)loadData
{
    [self.singleList addObjectsFromArray:[JMSearchTool createSearchSingleGoodsModel]];
    [self.listArray addObjectsFromArray:[[JMProductRecommend alloc] createProductRecommendModelAtCategoryIndex:0]];
    [self.interationArray addObjectsFromArray:[JMUserRecommendTool createUserRecommendModelWithListID:@"1872"]];
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{

    //collectionveiwHeader
    UIView *collectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 385)];
    collectionHeaderView.backgroundColor = [UIColor clearColor];
    
    //backImgView
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 230)];
    backImageView.image = [UIImage imageNamed:@"PersonCenterbackImage"];
    [self.view addSubview:backImageView];
    _backImageView = backImageView;
    
    //topview
    JMPersonCenterHeaderImageView *topView = [[JMPersonCenterHeaderImageView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 230)];
    topView->clickedImage =^(void){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更换头像" message:@"选取一张喜欢的图片" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"open camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"camera");
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"open album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"album");
            [self presentViewController:[[JMNaviViewController alloc] initWithRootViewController:[JMAlbumViewController new]] animated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    };
    [collectionHeaderView addSubview:topView];
    _topView = topView;
    
    [self.view addSubview:collectionHeaderView];
    _collectionHeadView = collectionHeaderView;
}

@end
