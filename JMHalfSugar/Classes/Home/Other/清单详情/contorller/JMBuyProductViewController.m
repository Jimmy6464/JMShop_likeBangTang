//
//  JMBuyProductViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMBuyProductViewController.h"

@interface JMBuyProductViewController ()<UIWebViewDelegate>
@property (nonatomic, weak)UIWebView *webView;
@end

@implementation JMBuyProductViewController
-(void)viewWillAppear:(BOOL)animated
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
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight)];
    webView.delegate = self;
    [self.view addSubview:webView];
    _webView = webView;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToLastPage)];
    self.navigationItem.backBarButtonItem = back;
    if (_productURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_productURL]];
        [_webView loadRequest:request];
    }else {
        [UIAlertController showAlertTips:@"没有数据" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0f compeletion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
}
- (void)backToLastPage
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setProductURL:(NSString *)productURL
{
    _productURL = productURL;
    
}

@end
