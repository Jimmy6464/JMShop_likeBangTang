//
//  JMSquareViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSquareViewController.h"
#import "JMTitleScrollView.h"
#import "JMSquareCategoryCell.h"
@interface JMSquareViewController ()<JMTitleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak)UICollectionView *collectionView;
@end

@implementation JMSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializedSubviews
{
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
    [collectioView registerNib:[UINib nibWithNibName:@"JMSquareCategoryCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"JMSquareCategoryCell"];
    collectioView.delegate = self;
    collectioView.dataSource = self;
    
}
#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index
{
    NSLog(@"clicked index:%ld",index);
}
@end
