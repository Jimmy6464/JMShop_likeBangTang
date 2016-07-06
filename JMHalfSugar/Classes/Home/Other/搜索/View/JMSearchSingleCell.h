//
//  JMSearchSingleCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMSearchModel;
@interface JMSearchSingleCell : UICollectionViewCell
@property (nonatomic, strong) JMSearchModel *searchModel;
@property (nonatomic, weak)UIImageView *iconImageView;
@property (nonatomic, weak)UILabel *nameLabel;
- (void)initializedSubviews;
@end
