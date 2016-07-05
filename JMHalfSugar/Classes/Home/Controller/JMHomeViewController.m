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
@interface JMHomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMBannerViewDelegate,JMTitleScrollViewDelegate,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)UIScrollView *mainScrllView;
@property (nonatomic, weak)JMBannerView *bannerView;
@property (nonatomic, weak)UIView *navigationBarBgView;
@property (nonatomic, weak)UISearchBar *searchBar;
@property (nonatomic, weak)UIButton *searchBtn;
@property (nonatomic, weak)UIButton *signBtn;
@property (nonatomic, weak)UIView *headerView;
@property (nonatomic, weak)UICollectionView *collectionView;
@property (nonatomic, weak)JMTitleScrollView *titleScrollView;
@property (nonatomic, strong)NSMutableArray *productArray;
@property (nonatomic, strong)NSMutableArray *bannerArray;
@property (nonatomic, strong)NSMutableArray *categoryArray;
@end

@implementation JMHomeViewController
static NSInteger _titleIndex = 0;
static CGPoint  _currentContentOffSet;
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
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadData];

    [self initializedSubviews];
        [self createCustomNavgationBar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- load data
- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.productArray = [[JMProductRecommend alloc] createProductRecommendModelAtCategoryIndex:0];
    });
    
}
#pragma mark - initialized subviews
- (void)createCustomNavgationBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 64)];
    
    UIView *navBgView = [[UIView alloc]initWithFrame:navBar.bounds];
    navBgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.0];
    [navBar addSubview:navBgView];
    _navigationBarBgView = navBgView;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(10, 0, 28, 28);
    searchButton.centerY = 42;
    [searchButton addTarget:self action:@selector(showSearching) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setImage:[UIImage imageNamed:@"search_normal"] forState:UIControlStateNormal];
    [navBar addSubview:searchButton];
    _searchBtn = searchButton;
    
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signInBtn setImage:[UIImage imageNamed:@"sign_normal"] forState:UIControlStateNormal];
    [signInBtn setImage:[UIImage imageNamed:@"sign_hl"] forState:UIControlStateHighlighted];
    signInBtn.frame = CGRectMake(JMDeviceWidth-32-10, 0, 28, 28);
    signInBtn.centerY = 42;
    [navBar addSubview:signInBtn];
    _signBtn = signInBtn;
    
    CGFloat searhBarWidth = JMDeviceWidth-signInBtn.width-15*3;
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(15-searhBarWidth, 0, searhBarWidth, 44)];
    searchBar.centerY = 42;
    searchBar.hidden = YES;
    searchBar.delegate  = self;
    searchBar.searchBarStyle =UISearchBarStyleMinimal;
    searchBar.barTintColor = [UIColor whiteColor];
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
}
- (void)initializedSubviews
{
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight)];
    mainView.delegate = self;
    [mainView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    mainView.contentSize = CGSizeMake(JMDeviceWidth, JMDeviceHeight+293);

    [self.view addSubview:mainView];
    mainView.contentOffset = CGPointZero;
    _mainScrllView = mainView;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 257+36)];
    [_mainScrllView addSubview:view];
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
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), JMDeviceWidth, JMDeviceHeight-64-_titleScrollView.height) collectionViewLayout:flowLayout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    collectionView.contentSize = CGSizeMake(_bannerArray.count*JMDeviceWidth, 0);
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [_mainScrllView addSubview:collectionView];
    _collectionView = collectionView;
    
   
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    UIScrollView *scrollView = object;
    CGFloat scrollY = scrollView.contentOffset.y;
    CGFloat tagetY = _headerView.height-_titleScrollView.height-64;
    if (tagetY == -64) {
        return;
    }
    NSLog(@"sc:%lf--------taget:%lf",scrollY,tagetY);
    if (scrollY>0&&scrollY<tagetY) {
        _navigationBarBgView.backgroundColor = [UIColor colorWithWhite:1 alpha:scrollY/tagetY];
        _searchBtn.alpha = (tagetY-scrollY)/tagetY;
        _signBtn.highlighted = NO;
        _signBtn.alpha  = (tagetY-scrollY)/tagetY;
        if ([self.view.subviews containsObject:_titleScrollView]) {
            [_titleScrollView removeFromSuperview];
            _titleScrollView.y = _headerView.height-_titleScrollView.height;
            [_headerView addSubview:_titleScrollView];
        }
        if (_searchBar.hidden == NO) {
            [UIView animateWithDuration:0.2 animations:^{
                _searchBar.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished == YES) {
                    _searchBar.hidden = YES;
                }
            }];
        }
    }
    if(scrollY>=tagetY){
        _navigationBarBgView.backgroundColor = [UIColor colorWithWhite:1 alpha:1.0];
        if ([_headerView.subviews containsObject:_titleScrollView]) {
            [_titleScrollView removeFromSuperview];
            _titleScrollView.y = 64;
            [self.view addSubview:_titleScrollView];
            [self.view bringSubviewToFront:_titleScrollView];
        }
        _searchBtn.alpha = 0.0;
        _signBtn.highlighted = YES;
        _signBtn.alpha = 1.0;
        [UIView animateWithDuration:0.2 animations:^{
            _searchBar.hidden = NO;
            _searchBar.transform = CGAffineTransformMakeTranslation(JMDeviceWidth-_signBtn.width-15*3, 0);
        }];
    }
    if (scrollY<0) {
         _navigationBarBgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.0];
        _searchBar.hidden = YES;
        _searchBtn.alpha = 1.0;
        _signBtn.alpha = 1.0;
        _signBtn.highlighted = NO;
    }
}
- (void)showSearching
{
    JMSearchViewController *search = [JMSearchViewController new];
    [search setHidesBottomBarWhenPushed:YES];
    [search.navigationController setNavigationBarHidden:NO];
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
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight-64-_titleScrollView.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView reloadData];
    [tableView setContentOffset:_currentContentOffSet animated:YES];
    _titleIndex = indexPath.section;
    [cell.contentView addSubview:tableView];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JMDeviceWidth, JMDeviceHeight-64-_titleScrollView.height);
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
    CGFloat scrollY = scrollView.contentOffset.y;
    CGFloat scrollX = scrollView.contentOffset.x;
    if ([scrollView isKindOfClass:[UITableView class]] && scrollView.contentOffset.x == 0) {
        if (scrollY < 0) {
            [_mainScrllView setContentOffset:CGPointMake(0, _mainScrllView.y+scrollY) ];
        }
        if (scrollY>0 && scrollY<_headerView.height-_titleScrollView.height){
            [_mainScrllView setContentOffset:CGPointMake(0, _mainScrllView.y+scrollY) ];
            
        }
        if (scrollY>_headerView.height-_titleScrollView.height) {
            [_mainScrllView setContentOffset:CGPointMake(0, _headerView.height-_titleScrollView.height) animated:YES];
        }
        _currentContentOffSet = scrollView.contentOffset;
    }
    NSLog(@"scrollY:%lf,scrollX:%lf,_mainScorllY:%lf",scrollY,scrollX,_mainScrllView.contentOffset.y);

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
            [self showSearching];
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
#pragma mark - 
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self showSearching];
    return NO;
}

@end
