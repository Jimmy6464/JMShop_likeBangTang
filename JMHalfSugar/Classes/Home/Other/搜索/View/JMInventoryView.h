//
//  JMInventoryView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMSearchModel;
@interface JMInventoryView : UIView
@property (nonatomic, strong) NSMutableArray<JMSearchModel *> *categoryModel;

@end
