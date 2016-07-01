//
//  UIAlertController+JMShowTips.m
//  EasyPay_HD
//
//  Created by Jimmy on 16/5/26.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "UIAlertController+JMShowTips.h"

@implementation UIAlertController (JMShowTips)
+ (void)showAlertTips:(NSString *)tips onView:(UIView *)view alertStyle:(UIAlertControllerStyle)style timeInterval:(CGFloat)timeIterval compeletion:(void (^)(void))compeletion
{
    id responder = [view nextResponder];
    UIViewController *viewController;
    while (YES) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            viewController = responder;
            break;
        }else {
            responder = [responder nextResponder];
        }
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips:" message:tips preferredStyle:style];
    [viewController presentViewController:alert animated:YES completion:^{
        sleep(timeIterval);
        [viewController dismissViewControllerAnimated:YES completion:compeletion];
    }];
}
@end
