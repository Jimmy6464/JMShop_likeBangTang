//
//  JMSearchListCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchSingleCell.h"
@class JMSerchLishModel;
@interface JMSearchListCell : JMSearchSingleCell
@property (nonatomic, strong)JMSerchLishModel *searchListModel;
- (void)setImageToCircle;
@end
