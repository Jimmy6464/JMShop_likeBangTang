//
//  JMCommentViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMCommentViewController.h"

@interface JMCommentViewController ()<UITextViewDelegate>
@property (nonatomic, strong)UITextView *commentTextView;
@property (nonatomic, strong)UILabel *placeHolderLabel;
@end

@implementation JMCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializedSubviews];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [_commentTextView becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initialized subviews
- (void)initializedSubviews
{
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissVC)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(dismissVC)];
    self.navigationItem.rightBarButtonItem = confirmItem;
    
    //
    self.commentTextView = [[UITextView alloc]initWithFrame:CGRectMake(5, 8, JMDeviceWidth-10, 500)];
    _commentTextView.layer.cornerRadius = 3.0;
    _commentTextView.layer.borderColor =  JMLightLineColor.CGColor;
    _commentTextView.layer.borderWidth =  0.5;
    _commentTextView.delegate  =self;
    _commentTextView.font = [UIFont systemFontOfSize:15.0];
    _commentTextView.textColor = JMMainTitleColor;
    [self.view addSubview:_commentTextView];
    //
    _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 16, 60, 15.0)];
    _placeHolderLabel.textColor = JMGrayLineColor;
    _placeHolderLabel.text = @"Make some comments";
    [_placeHolderLabel sizeToFit];
    [self.view addSubview:_placeHolderLabel];
}
#pragma mark - 
- (void)dismissVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placeHolderLabel.text = @"Make some comments";
    }else
    {
        _placeHolderLabel.text = @"";
    }
}
@end
