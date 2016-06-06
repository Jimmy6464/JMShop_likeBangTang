//
//  JMBannerView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMBannerViewDelegate <NSObject>



@end
@interface JMBannerView : UIView
@property (nonatomic, weak) id <JMBannerViewDelegate> delegate;
@end
