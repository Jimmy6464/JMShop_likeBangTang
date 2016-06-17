//
//  JMProductTitleView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMProductDetailModel;

@interface JMProductTitleView : UIView
@property (nonatomic, strong) JMProductDetailModel *model;
@property (nonatomic, assign) CGFloat contentOffsetY;
@end
