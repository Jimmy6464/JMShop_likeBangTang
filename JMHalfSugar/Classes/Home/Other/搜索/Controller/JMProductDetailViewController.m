//
//  JMProductDetailViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductDetailViewController.h"
#import "JMProductTitleView.h"
#import "JMProductCommentCell.h"
#import "JMPorductDetailTool.h"
#import "JMProductDetailModel.h"
#import "JMCommentModel.h"
@interface JMProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak)JMProductTitleView *titleView;
@property (nonatomic, weak)UIView *bottomView;
@property (nonatomic, strong)NSMutableArray *comments;
@end

@implementation JMProductDetailViewController
static CGFloat _scrollViewheight = 0;
static CGFloat _imageHeight = 250;
- (NSMutableArray *)comments
{
    if (!_comments) {
        _comments = [NSMutableArray new];
        JMProductDetailModel *model = [JMPorductDetailTool createProductDetailModel];
        [_comments addObjectsFromArray: model.comment_list];
    }
    return _comments;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    //titleView
    JMProductTitleView *titleView = [[JMProductTitleView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 300)];

    JMProductDetailModel *model = [JMPorductDetailTool createProductDetailModel];
    titleView.model = model;
    titleView.autoresizesSubviews= YES;
    _titleView = titleView;
    [self.view layoutIfNeeded];
    _scrollViewheight = _titleView.height;

    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight-64-44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(titleView.height, 0, 0, 0);
    [self.view addSubview:tableView];
    _tableView = tableView;
    _titleView.y = -_titleView.height;
    [tableView addSubview:titleView];
    _tableView = tableView;
    
    //bottom view;
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tableView.frame), JMDeviceWidth, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    commentBtn.frame = CGRectMake(26, 12, 60, 20);

    commentBtn.titleLabel.font = [UIFont fontWithName:LightFont size:15.0];
    [commentBtn setTitleColor:JMGrayLineColor forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateHighlighted];
    [commentBtn addTarget:self action:@selector(goToComment) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:commentBtn];
    
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    likeBtn.frame = CGRectMake(CGRectGetMaxX(commentBtn.frame)+50, 12, 60, 20);
    [likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
    [likeBtn setTitleColor:JMGrayLineColor forState:UIControlStateNormal];
    likeBtn.titleLabel.font = [UIFont fontWithName:LightFont size:15.0];
    [likeBtn setImage:[UIImage imageNamed:@"addToFavoriteBtn"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"addToFavoriteBtn"] forState:UIControlStateHighlighted];
    [likeBtn setImage:[UIImage imageNamed:@"addToFavoriteBtn_selected"] forState:UIControlStateSelected];
    [likeBtn addTarget:self action:@selector(likeOrDislikeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:likeBtn];
    _bottomView = bottomView;
}
- (void)goToComment
{
    
}
-(void)likeOrDislikeAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setImage:[UIImage imageNamed:@"addToFavoriteBtn_selected"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            sender.transform = CGAffineTransformIdentity;
        }];
    }else {
        [sender setImage:[UIImage imageNamed:@"addToFavoriteBtn"] forState:UIControlStateHighlighted];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.comments.count) {
        return _comments.count;
    }else {
        return 0;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMProductCommentCell *cell = [JMProductCommentCell cellWithTableView:tableView];
    cell.model = _comments[indexPath.row];
    return cell;
 
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMCommentModel *modle = _comments[indexPath.row];
    if (modle.cellHeight != 0) {
        return modle.cellHeight;
    }else {
        return 100;
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%lf",y);
    if (y < -_scrollViewheight) {
        _titleView.contentOffsetY = _imageHeight + (-_scrollViewheight-y);
        CGRect frame = _titleView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _titleView.frame = frame;
    }
}
@end
