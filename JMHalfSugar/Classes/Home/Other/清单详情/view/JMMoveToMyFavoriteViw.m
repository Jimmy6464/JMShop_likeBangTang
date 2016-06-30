//
//  JMMoveToMyFavoriteViw.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMMoveToMyFavoriteViw.h"
#import "UITableView+RemoveEmptyCell.h"
#import "JMFavoriteCell.h"
@interface JMMoveToMyFavoriteViw ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UIView *mainView;
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, copy) NSString *productID;
@property (nonatomic, strong) NSDictionary *picArray;
@end
@implementation JMMoveToMyFavoriteViw
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.7];
        self.picArray = @{@"01":@"我喜欢",@"02":@"午休神器",@"03":@"办公桌上一抹绿",@"04":@"已中毒的手纸",@"05":@"涂涂画画",@"06":@"效率神器",@"07":@"文具控"};
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews
{

    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(self.width/5/2, self.height/5, self.width/5*4, self.height/5*3)];
    mainView.layer.cornerRadius = 10.f;
    mainView.clipsToBounds = YES;
    mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mainView];
    _mainView = mainView;
    
    [self setUpTitleView];
    //
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), _mainView.width, _mainView.height/7*4) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource =self;
//    [tableView removeEmptyCellRows];
    [_mainView addSubview:tableView];
    _tableView = tableView;
    //
    [self setUpBottomView];
}
- (void)setUpTitleView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.width, _mainView.height/7)];
    [_mainView addSubview:titleView];
    _titleView = titleView;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    titleLabel.text = @"移动至心愿列表";
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(_titleView.width/2, _titleView.height/2);
    [_titleView addSubview:titleLabel];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, _titleView.height-1, _titleView.width, 1.0)];
    bottomLine.backgroundColor = JMCustomBarTintColor;
    [_titleView addSubview:bottomLine];
    
    //
    UIButton *cancelButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(_titleView.width-40, 0, 40, 40);
    cancelButton.centerY = _titleView.height/2;
    [cancelButton addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:cancelButton];
    
}
- (void)setUpBottomView
{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), _mainView.width, _mainView.height/7*2)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [_mainView addSubview:bottomView];
    _bottomView = bottomView;
    
    UIButton *createListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [createListBtn setTitle:@"+ 创建心愿单" forState:UIControlStateNormal];
    createListBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [createListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createListBtn setBackgroundColor:JMCustomBarTintColor];
    [createListBtn sizeToFit];
    [createListBtn addTarget:self action:@selector(createNewList:) forControlEvents:UIControlEventTouchUpInside];
    createListBtn.centerX = _bottomView.width/2;
    createListBtn.centerY = _bottomView.height/4;
    [_bottomView addSubview:createListBtn];
    
    //
    UIButton *cancelLikeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelLikeBtn setTitle:@"取消喜欢" forState:UIControlStateNormal];
    cancelLikeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [cancelLikeBtn setTitleColor:[UIColor colorWithHexString:@"9D9D9D"] forState:UIControlStateNormal];
    [cancelLikeBtn sizeToFit];
    [cancelLikeBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    cancelLikeBtn.centerX = _bottomView.width/2;
    cancelLikeBtn.centerY = _bottomView.height/4*3;
    [_bottomView addSubview:cancelLikeBtn];
}
- (void)createNewList:(UIButton *)btn
{
    [self.delegate  createANewList];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.picArray.allKeys.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMFavoriteCell *cell = [JMFavoriteCell cellWithTableView:tableView title:self.picArray[[NSString stringWithFormat:@"0%ld",indexPath.row+1]] atIndexPath:indexPath];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  _mainView.height/7;
}
#pragma mark - public method
- (void)showWithAnimation:(NSString *)productID
{
    self.productID = productID;
    [JMKeyWindow addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.center = CGPointMake(JMDeviceWidth/2, JMDeviceHeight/2);
    }];
}
- (void)hiddenView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.centerY = JMDeviceHeight+JMDeviceHeight/2;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
