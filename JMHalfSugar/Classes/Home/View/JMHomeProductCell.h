//
//  JMHomeProductCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMProductRecommendModel;
@interface JMHomeProductCell : UITableViewCell
@property (nonatomic, strong) JMProductRecommendModel *model;
@property (nonatomic, weak) UIImageView *imageV;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
