//
//  JMGenderSelectedViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/7/4.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMGenderSelectedViewController.h"

@interface JMGenderSelectedViewController ()
@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic, strong)UIButton *manButton;
@property (nonatomic, strong)UIButton *womanButton;
@property (nonatomic, strong)UIButton *completeBtn;
@end

@implementation JMGenderSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    //
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _tipLabel.text = @"请问你是帅帅哒还是美美哒\n说说也没有什么大不了嘛";
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.font = [UIFont fontWithName:LightFont size:16.0];
    _tipLabel.textColor = JMCustomBarTintColor;
    _tipLabel.numberOfLines = 0;
    [_tipLabel sizeToFit ];
    _tipLabel.frame = CGRectMake(0, 30, JMDeviceWidth, 45);
    [self.view addSubview:_tipLabel];
    
    //
    _manButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _manButton.frame = CGRectMake(30, 120, 102, 150);
    _manButton.tag = 110;
    [_manButton setImage:[UIImage imageNamed:@"Man_unselected"] forState:UIControlStateNormal];
    [_manButton setImage:[UIImage imageNamed:@"Man_selected"] forState:UIControlStateSelected];
    _manButton.adjustsImageWhenHighlighted = false;
    [_manButton addTarget:self action:@selector(clickCenter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_manButton];
    
    //
    _womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _womanButton.frame = CGRectMake(JMDeviceWidth - 30 - 102, 120, 102, 150);
    _womanButton.tag = 111;
    [_womanButton setImage:[UIImage imageNamed:@"Woman_unselected"] forState:UIControlStateNormal];
    [_womanButton setImage:[UIImage imageNamed:@"Woman_selected"] forState:UIControlStateSelected];
    _womanButton.adjustsImageWhenHighlighted = false;
    [_womanButton addTarget:self action:@selector(clickCenter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_womanButton];
    
    //
    _completeBtn =[ UIButton buttonWithType:UIButtonTypeCustom];
    _completeBtn.layer.cornerRadius = 17.0;
    _completeBtn.backgroundColor = JMCustomBarTintColor;
    [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    _completeBtn.titleLabel.font = [UIFont fontWithName:LightFont size:20.0];
    [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_completeBtn sizeToFit];
    _completeBtn.frame = CGRectMake(JMDeviceWidth/2-158/2-_completeBtn.width/2, JMDeviceHeight-64-_completeBtn.height-24-10, _completeBtn.width+158, _completeBtn.height);
    [_completeBtn addTarget:self action:@selector(clickCompleteBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_completeBtn];
    
    //
    NSString *object = [[NSUserDefaults standardUserDefaults] objectForKey:@"gender"];
    if (object == nil || [object isEqualToString:@"male"]) {
        _manButton.selected = YES;
    }else {
        _womanButton.selected = YES;
    }
}
#pragma mark
- (void)clickCenter:(UIButton *)btn
{
    if (btn.tag == 110) {
        _womanButton.selected = NO;
        _manButton.selected = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"male" forKey:@"gender"];
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:@"female" forKey:@"gender"];
        _womanButton.selected = YES;
        _manButton.selected = NO;
    }

}
- (void)clickCompleteBtn
{
    [JMNotificationCenter postNotificationName:JMChangeGender object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/*
 tipLabel = UILabel(frame: CGRectZero)
 tipLabel.text = "请问你是帅帅哒还是美美哒\n说说也没有什么大不了嘛"
 tipLabel.textAlignment = .Center
 tipLabel.font = UIFont(name: LightFont, size: 16.0)
 tipLabel.textColor = CustomBarTintColor
 tipLabel.numberOfLines = 0
 tipLabel.sizeToFit()
 tipLabel.frame = CGRectMake(0, 30, SCREEN_WIDTH, 45)
 view.addSubview(tipLabel)
 
 manButton.frame = CGRectMake(30, 120, 102, 150)
 manButton.tag = 110
 manButton.setImage(UIImage(named: "Man_selected"), forState: .Selected)
 manButton.setImage(UIImage(named: "Man_unselected"), forState: .Normal)
 manButton.adjustsImageWhenHighlighted = false
 manButton.selected = true
 manButton.addTarget(self, action: "clickCenter:", forControlEvents: .TouchUpInside)
 view.addSubview(manButton)
 
 womanButton.frame = CGRectMake(SCREEN_WIDTH - 30 - 102, 120, 102, 150)
 womanButton.tag = 111
 womanButton.setImage(UIImage(named: "Woman_selected"), forState: .Selected)
 womanButton.setImage(UIImage(named: "Woman_unselected"), forState: .Normal)
 womanButton.adjustsImageWhenHighlighted = false
 womanButton.addTarget(self, action: "clickCenter:", forControlEvents: .TouchUpInside)
 view.addSubview(womanButton)
 
 
 completeBtn.layer.cornerRadius = 17.0
 completeBtn.backgroundColor = CustomBarTintColor
 completeBtn.setTitle("完成", forState: .Normal)
 completeBtn.titleLabel?.font = UIFont(name: LightFont, size: 20.0)
 completeBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
 completeBtn.sizeToFit()
 completeBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 158/2 - completeBtn.frame.width/2, SCREEN_HEIGHT - 64 - completeBtn.frame.height - 24 - 10, completeBtn.frame.width + 158,  completeBtn.frame
 .height)
 completeBtn.addTarget(self, action: "clickComplete", forControlEvents: .TouchUpInside)
 view.addSubview(completeBtn)

 */

@end
