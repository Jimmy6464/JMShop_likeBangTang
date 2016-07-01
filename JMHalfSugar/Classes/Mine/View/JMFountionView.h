//
//  JMFountionView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMFountionView : UIView
{
    @public void (^buttonClicked)(NSUInteger tag);
}
@end
