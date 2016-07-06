//
//  JMSignInViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/7/5.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSignInViewController.h"
#import "JMScoreCell.h"
#import "JMSignInCell.h"
@interface JMSignInViewController ()

@end

@implementation JMSignInViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"JMScoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JMScoreCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JMSignInCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JMSignInCell"];
    
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_hl"] style:UIBarButtonItemStyleDone target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = shareBtn;
}
- (void)shareAction
{
    [UIAlertController showAlertTips:@"nothing can be catched" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0 compeletion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignInCell"];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"JMScoreCell"];
    }
    return cell;
}
#pragma mark - 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 400:123;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0? 0:10;
}
@end
