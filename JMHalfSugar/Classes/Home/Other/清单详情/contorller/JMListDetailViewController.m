//
//  JMListDetailViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/21.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailViewController.h"
#import "JMBuyProductViewController.h"
#import "JMCommentViewController.h"

#import "JMListDetailCell.h"
#import "JMListRecommendCell.h"
#import "JMListHeaderView.h"
#import "JMSegmentView.h"
#import "JMMoveToMyFavoriteViw.h"

#import "JMListDetailTool.h"
#import "JMUserRecommendTool.h"
#import "JMUserRecommendModel.h"
#import "JMUserRecommendProductModel.h"
#import "JMListDetailProductModel.h"
#import "JMListModel.h"
typedef enum : NSUInteger {
    BanTangGoodSelectMode,
    UserRecommendMode,
} TableViewMode;
@interface JMListDetailViewController ()<JMSegmentViewDelegate,UITableViewDataSource,UITableViewDelegate,JMListDetailCellDelegate,JMListRecommendCellDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) JMListHeaderView *headerview;
@property (nonatomic, weak) JMSegmentView *segmentView;
@property (nonatomic, strong) JMListModel *listModel;
@property (nonatomic, assign) TableViewMode tableViewMode;

@property (nonatomic, strong)NSMutableArray *recommendArray;
@property (nonatomic, strong)UIView *customBar;
@property (nonatomic, strong)UIButton *favoriteBtn;
@property (nonatomic, strong)UIButton *shareBtn;
@property (nonatomic, strong)UIView *navBackView;
@property (nonatomic, strong)UIView *tableHeadView;


@end
@implementation JMListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    //
    [self createCustomBar];
    //
    [self loadData];
    //
    if (_listModel) {
        [self initializedSubviews];
    }else {
        [UIAlertController showAlertTips:@"nothing" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0f compeletion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

#pragma mark - loadData
- (void)loadData
{
    _listModel = [JMListDetailTool createListModelWithListID:_listID];
    if (_listModel != nil) {
        _recommendArray = [NSMutableArray arrayWithArray:[JMUserRecommendTool createUserRecommendModelWithListID:_listID]];
    }
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    JMListHeaderView *headerView = [[JMListHeaderView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 0) withTitle:_listModel.title subTitle:_listModel.detailText andImage:_image];
    _headerview = headerView;
    [self buildSegmentView];
    CGRect frame = headerView.frame;
    frame.size.height +=45;
    headerView.frame = frame;

    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    _tableView = tableView;
    _headerview = headerView;

    
    [self.view bringSubviewToFront:_navBackView];
    [self.view bringSubviewToFront:_customBar];
}
- (void)buildSegmentView
{
    JMSegmentView *segmentView = [[JMSegmentView alloc]initWithFrame:CGRectMake(0, _headerview.height, JMDeviceWidth, 45) firstTitle:@"半糖精选" secondTitle:@"用户推荐"];
    _segmentView.backgroundColor = [UIColor whiteColor];
    segmentView.delegate = self;
    [_headerview addSubview:segmentView];
    _segmentView = segmentView;
}
- (void)createCustomBar
{
    [self.navigationController setNavigationBarHidden:YES];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    UIView *customeBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 64)];
    customeBar.backgroundColor = [UIColor clearColor];
    
    UIView *navBackView = [[UIView alloc]initWithFrame:customeBar.frame];
    navBackView.backgroundColor = [UIColor colorWithHexString:@"EC5252" alpha:0.0];
    [self.view addSubview:navBackView];
    [self.view addSubview:customeBar];
    
    _customBar = customeBar;
    _navBackView = navBackView;
    
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(JMDeviceWidth/2-36, 33, 18*10, 20)];
    titleLabel.hidden = YES;
    titleLabel.text = @"Shopping list";
    titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [_customBar addSubview:titleLabel];
    [titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_customBar withOffset:5];
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];

    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(JMDeviceWidth-39, 30, 20, 20);
    [shareBtn setImage:[UIImage imageNamed:@"goodsDetail_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_customBar addSubview:shareBtn];
    [shareBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:titleLabel];
    [shareBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    
    UIButton *favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favBtn.frame = CGRectMake(476/2, 30, 20, 20);
    [favBtn setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    [favBtn setImage:[UIImage imageNamed:@"favorite_hl" ] forState:UIControlStateSelected];
    [favBtn addTarget:self action:@selector(favoriteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_customBar addSubview:favBtn];
    [favBtn autoSetDimensionsToSize:CGSizeMake(20, 20)];
    [favBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:titleLabel];
    [favBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:shareBtn.width+20+20];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(17, 30, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToController:) forControlEvents:UIControlEventTouchUpInside];
    [_customBar addSubview:backBtn];
    [backBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:titleLabel];
    [backBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:17];
}
#pragma mark - NavBtnAction
- (void)favoriteBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIAlertController showAlertTips:@"谢谢你的收藏" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0f compeletion:^{
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:_listID];
        }];
    }else {
        [UIAlertController showAlertTips:@"取消收藏" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0f compeletion:^{
            [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:_listID];
        }];
    }
}
- (void)shareBtnAction:(UIButton *)sender
{
    [UIAlertController showAlertTips:@"Nothing can be catched" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0f compeletion:nil];
}
- (void)backToController:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - JMSegmentViewDelegate
- (void)clickSegmentViewAtIndex:(NSInteger)index
{
    if (_tableViewMode == BanTangGoodSelectMode) {
        _tableViewMode = UserRecommendMode;
    }else {
        _tableViewMode = BanTangGoodSelectMode;
    }
    [_tableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_tableViewMode == BanTangGoodSelectMode) {
        if (self.listModel.prouctArray !=nil) {
            return _listModel.prouctArray.count;
        }else {
            return 1;
        }
    }else {
        if (_recommendArray != nil) {
            return _recommendArray.count;
        }else {
            return 1;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableViewMode == BanTangGoodSelectMode) {
        JMListDetailProductModel *model =  _listModel.prouctArray[indexPath.section];
        JMListDetailCell *cell = [JMListDetailCell cellWithTableView:tableView atIndexPath:indexPath withModel:model];
        cell.delegate = self;
        return cell;
    }else {
        JMListRecommendCell *cell = [JMListRecommendCell cellWithTableView:tableView atIndexPath:indexPath withModel:self.recommendArray[indexPath.section]];
        cell.delegate = self;
        return cell;
    }
}
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tableViewMode == BanTangGoodSelectMode) {
        JMListDetailProductModel *model = _listModel.prouctArray[indexPath.section];
        if (model.cellHeight > 0) {
            return model.cellHeight;
        }
        return 400;
    }else {
        JMUserRecommendModel *model = _recommendArray[indexPath.section];
        if (model.cellHeight>0) {
            return model.cellHeight;
        }
        return 200;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return 10;
    }else {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *cellHeaderView = [[UIView alloc]init];
    cellHeaderView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    return cellHeaderView;
}
#pragma mark - JMListDetailCellDelegate
- (void)checkProductDetails:(NSInteger)productID
{
    NSLog(@"%ld",productID);
}
- (void)clickCenterWithType:(ListDetailCellClickType)clickType atIndexPath:(NSIndexPath *)indexPath
{
    switch (clickType) {
        case AllowComment_type:
        {
            [self.navigationController pushViewController:[JMCommentViewController new] animated:YES];
            break;
        }
        case NotAllowComment_type:
        {
            [self.navigationController pushViewController:[JMCommentViewController new] animated:YES];
            break;
        }
        case LikeIt_type:
        {
            NSLog(@"collected");
            break;
        }
        case MoveToOtherFavoriteList_type:
        {
            JMListDetailProductModel *model = _listModel.prouctArray[0];
            JMMoveToMyFavoriteViw *moveView = [[JMMoveToMyFavoriteViw alloc]initWithFrame:CGRectMake(0, JMDeviceHeight, JMDeviceWidth, JMDeviceHeight)];
            [moveView showWithAnimation:model.productID];
            break;
        }
        case BuyThisProduct_type:
        {
            JMListDetailProductModel *product = _listModel.prouctArray[0];
            JMBuyProductViewController *buyPro = [[JMBuyProductViewController alloc]init];
            buyPro.productURL = product.productUrl;
            [self.navigationController pushViewController:buyPro animated:YES];
        }
        default:
            break;
    }
}
#pragma mark - JMListRecommendCellDelegate
- (void)listRecommendClickCenter:(ListDetailCellClickType)clickType atIndexPath:(NSIndexPath *)indexPath
{
    switch (clickType) {
        case AllowComment_type:
        {
            [self.navigationController pushViewController:[JMCommentViewController new] animated:YES];
            break;
        }
        case LikeIt_type:
        {
            JMUserRecommendModel *model = _recommendArray[indexPath.section];
            JMUserRecommendProductModel *product = model.productArray[0];
            product.isCollect = YES;
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:[NSString stringWithFormat:@"%d",product.isCollect]];
            break;
        }
        case BuyThisProduct_type:
        {
            JMUserRecommendModel *model = _recommendArray[indexPath.section];
            JMUserRecommendProductModel *product = model.productArray[0];
            JMBuyProductViewController *buyPro = [[JMBuyProductViewController alloc]init];
            buyPro.productURL = product.url;
            [self.navigationController pushViewController:buyPro animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollY = scrollView.contentOffset.y;
    NSLog(@"%lf",scrollY);
    if (scrollY>= 0 && scrollY < _headerview.height-64-_segmentView.height) {
        _navBackView.backgroundColor = [UIColor colorWithHexString:@"EC5252" alpha:scrollY/(_headerview.height-64-_segmentView.height)];
        [_segmentView removeFromSuperview];
        _segmentView.y = _headerview.height-_segmentView.height;
        [_headerview addSubview:_segmentView];
    }else if (scrollY <= 0 ){

    }else if(scrollY == _headerview.height-64-_segmentView.height ||scrollY>_headerview.height-64-_segmentView.height ) {
        _navBackView.backgroundColor = JMCustomBarTintColor;
        _segmentView.y = 64;
        [self.view addSubview:_segmentView];
        
    }
    NSLog(@"%lf",scrollView.contentOffset.y);
}
@end
