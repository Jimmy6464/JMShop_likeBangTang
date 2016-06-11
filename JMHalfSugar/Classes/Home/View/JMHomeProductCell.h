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
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
