//
//  JMMessageViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMMessageViewController.h"
#import "JMTitleScrollView.h"
@interface JMMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)JMTitleScrollView *titleScrollView;
@end

@implementation JMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"消息";
    [self initializedSubviews];
    // Do any additional setup after loading the view.
}
- (void)initializedSubviews
{
    //titlescrollview
    JMTitleScrollView *titleScrollview = [[JMTitleScrollView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 45) titleArray:@[@"通知",@"喜欢",@"评论"] fontSize:16.0 _textLength:2 andButtonSpacing:(JMDeviceWidth-40-3*30)/2];
    [self.view addSubview:titleScrollview];
    _titleScrollView = titleScrollview;
    
    //tableview
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, JMDeviceWidth, JMDeviceHeight-64-44-45) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    _tableView = tableview;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, tableView.height)];
        imageView.image = [UIImage imageNamed:@"nomessage"];
        [cell.contentView addSubview:imageView];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableView.height;
}

@end
