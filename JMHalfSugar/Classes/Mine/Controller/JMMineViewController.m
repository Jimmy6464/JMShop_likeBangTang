//
//  JMMineViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMMineViewController.h"

#import "JMAlbumViewController.h"

#import "JMPersonCenterHeaderImageView.h"
#import "JMTitleScrollView.h"
#import "JMFountionView.h"
#import "JMPersonCenterActivityCell.h"
#import "JMPersonCenterListCell.h"
#import "JMPersonCenterSingleCell.h"


#import "JMSearchTool.h"
#import "JMSearchSingleGoodsModel.h"
#import "JMUserRecommendTool.h"
#import "JMUserRecommendModel.h"
#import "JMProductRecommend.h"

enum ShowCollectionViewType {
    /// 单品
    SingleMode = 10,
    /// 清单
    ListMode,
    /// 互动
    ActivityMode,
    /// 发布
    PublishMode
};
@interface JMMineViewController ()<JMTitleScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak)JMPersonCenterHeaderImageView *topView;
@property (nonatomic, weak)UIImageView *headerImageView;
@property (nonatomic, weak)JMTitleScrollView *titleView;
@property (nonatomic, weak)UIImageView *backImageView;
@property (nonatomic, strong)UIView *collectionHeadView;
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
    self.view.backgroundColor = [UIColor whiteColor];
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
    self.collectionViewType = SingleMode;
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
            UIImagePickerController *imagePicker = [UIImagePickerController new];
            imagePicker.delegate = self;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }else {
                NSLog(@"nothing");
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"open album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"album");
            [self presentViewController:[[JMNaviViewController alloc] initWithRootViewController:[JMAlbumViewController new]] animated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    };
    [collectionHeaderView addSubview:topView];
    _topView = topView;
    
    //fountionview
    JMFountionView *fountionView = [[JMFountionView alloc]initWithFrame:CGRectMake(0, 230, JMDeviceWidth, 111)];
    fountionView->buttonClicked = ^(NSUInteger tag){
        NSLog(@"%ld",tag);
    };
    [collectionHeaderView addSubview:fountionView];
    
    //titleView
    CGFloat margin = (JMDeviceWidth-40-4*30)/3;
    JMTitleScrollView *titleScrollView = [[JMTitleScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame)+111, JMDeviceWidth, 45) titleArray:@[@"单品",@"清单",@"互动",@"发布"] fontSize:15.0 _textLength:2 andButtonSpacing:margin];
    titleScrollView.tDelegate = self;
    [collectionHeaderView addSubview:titleScrollView];
    self.titleView = titleScrollView;
    _collectionHeadView = collectionHeaderView;
    [self setUpCollectionView];

}
- (void)setUpCollectionView
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.sectionInset = UIEdgeInsetsZero;
    flowlayout.headerReferenceSize = CGSizeMake(JMDeviceWidth, 385);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.minimumLineSpacing = 10;
    
    UICollectionView *showCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight-49) collectionViewLayout:flowlayout];
    showCollectionView.delegate = self;
    showCollectionView.dataSource = self;
    showCollectionView.backgroundColor = [UIColor clearColor];
    
    //register single product
    [showCollectionView registerClass:[JMPersonCenterSingleCell class] forCellWithReuseIdentifier:@"JMPersonCenterSingleCell"];
    [showCollectionView registerClass:[JMPersonCenterListCell class] forCellWithReuseIdentifier:@"JMPersonCenterListCell"];
    [showCollectionView registerClass:[JMPersonCenterActivityCell class] forCellWithReuseIdentifier:@"JMPersonCenterActivityCell"];
    [showCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"JMPersonCenterPublicCell"];
    [showCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    [self.view addSubview:showCollectionView];
    _showCollectionView = showCollectionView;
    
}
#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            _collectionViewType = SingleMode;
            break;
        case 1:
            _collectionViewType = SingleMode;
            break;
        case 2:
            _collectionViewType = SingleMode;
            break;
        case 3:
            _collectionViewType = SingleMode;
            break;
        default:
            break;
    }
    [_showCollectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_collectionViewType == SingleMode) {
        return self.singleList.count;
    }else if (_collectionViewType == ListMode){
        return self.listArray.count;
    }else if (_collectionViewType == ActivityMode){
        return self.interationArray.count;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ffds");
    switch (_collectionViewType) {
        case SingleMode:
        {
            JMPersonCenterSingleCell *cell = [JMPersonCenterSingleCell cellWithCollectionView:collectionView atIndexPath:indexPath andModel:self.singleList[indexPath.item]];
            return cell;
            break;
        }
        case ListMode:
        {
            JMPersonCenterListCell *cell = [JMPersonCenterListCell cellWithCollectionView:collectionView atIndexPath:indexPath andModel:self.listArray[indexPath.item]];
            return cell;
            break;
        }
        case ActivityMode:
        {
            JMPersonCenterActivityCell *cell = [JMPersonCenterActivityCell cellWithCollectionView:collectionView atIndexPath:indexPath andModel:self.interationArray[indexPath.item]];
            return cell;
            break;
        }
            
        case PublishMode:
        {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JMPersonCenterPublicCell" forIndexPath:indexPath];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(JMDeviceWidth/2-85, 60, 170, 170)];
            imageView.image = [UIImage imageNamed:@"PersonCenterPublish"];
            [cell.contentView addSubview:imageView];
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_collectionViewType) {
        case SingleMode:
            return CGSizeMake(145, 170);
            break;
        case ListMode:
            return CGSizeMake(JMDeviceWidth, 171+63);
            break;
        case ActivityMode:
            return CGSizeMake(145, 225);
            break;
        default:
            break;
    }
    return CGSizeMake(JMDeviceWidth, JMDeviceHeight-64-45-49-45);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat margin = (JMDeviceWidth-2*145)/4;
    if (_collectionViewType == SingleMode || _collectionViewType == ActivityMode) {
        return UIEdgeInsetsMake(10, margin, 10, margin);
    }
    return UIEdgeInsetsZero;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseView ;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *collectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        [collectionHeaderView  addSubview:_collectionHeadView];
        reuseView = collectionHeaderView;
    }
    return reuseView;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollY = scrollView.contentOffset.y;
    
    if (scrollY>= 0 && scrollY < 230+111) {
        self.backImageView.y = -scrollY;
        //put the titleView back on the collectionHeaderView
        [self.titleView removeFromSuperview];
        self.titleView.frame = CGRectMake(0, 230+111, JMDeviceWidth, 45);
        [_collectionHeadView addSubview:_titleView];
    }else if (scrollY <= 0 ){
        CGFloat scale = (230-scrollY)/230;
        _backImageView.transform = CGAffineTransformMakeScale(scale, scale);
        _backImageView.frame = CGRectMake(-JMDeviceWidth*(scale-1)/2, 0, JMDeviceWidth*scale, scale*230);
        
    }else if(scrollY == 341 ||(scrollY>341 && _titleView.y != 45)) {
        //(scrollY>341 && _titleView.y != 45) 防止滚动过快 titleView没有移除
        [_titleView removeFromSuperview];
        _titleView.frame = CGRectMake(0, 20, JMDeviceWidth, 45);
        _titleView.layer.zPosition = 2.0;
        [self.view addSubview:_titleView];
    }
}
@end
