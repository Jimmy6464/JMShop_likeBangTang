//
//  JMListRecommendCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/22.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMListDetailCell.h"
@class JMUserRecommendModel;

@protocol  JMListRecommendCellDelegate <NSObject>
- (void)listRecommendClickCenter:(ListDetailCellClickType)clickType atIndexPath:(NSIndexPath *)indexPath;

@end
@interface JMListRecommendCell : UITableViewCell
@property (nonatomic, weak) id<JMListRecommendCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(JMUserRecommendModel *)model;
@end
