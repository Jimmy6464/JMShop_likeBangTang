//
//  JMListRecommendCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/22.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMUserRecommendModel;
@interface JMListRecommendCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(JMUserRecommendModel *)model;
@end
