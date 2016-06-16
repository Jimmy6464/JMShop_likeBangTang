//
//  JMInventoryView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMInventoryView.h"
#import "UIColor+Hex.h"
#import "JMSearchListCell.h"
#import "JMSearchModel.h"
@interface JMInventoryView ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *searchModel;
@end
@implementation JMInventoryView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, self.height) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    [self addSubview:tableview];
    _tableView = tableview;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.minimumLineSpacing = 0.0f;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(80, 0, self.width-80, self.height) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.contentSize = CGSizeMake(0, self.height*1.5f);
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[JMSearchSingleCell class] forCellWithReuseIdentifier:@"SingleCell"];
    [self addSubview:collectionView];
    _collectionView = collectionView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryModel.count > 0 ? self.categoryModel.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"tabaleviewcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0" alpha:1.0];
        //selected backgroundView
        UIView *bgView = [[UIView alloc]initWithFrame:cell.frame];
        bgView.backgroundColor = [UIColor whiteColor];
        //selected indicatorView
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 44)];
        indicatorView.backgroundColor = JMCustomBarTintColor;
        [bgView addSubview:indicatorView];
        
        cell.selectedBackgroundView = bgView;
        //list name
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40-13, 25-13/2, 26, 13)];
        label.text = self.categoryModel[indexPath.row].name;
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textColor = JMCustomBarTintColor;
        [cell.contentView addSubview:label];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.searchModel = self.categoryModel[indexPath.row].subList;
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchModel.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMSearchSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SingleCell" forIndexPath:indexPath];
    cell.searchModel = self.searchModel[indexPath.item];
    return cell;
}
#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 0, 15);
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectedItem:indexPath];
}
- (void)setCategoryModel:(NSMutableArray<JMSearchModel *> *)categoryModel
{
    _categoryModel = categoryModel;
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    self.searchModel = _categoryModel[0].subList;
    [self.collectionView reloadData];
}
@end
