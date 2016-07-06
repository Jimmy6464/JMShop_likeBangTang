//
//  JMProductCommentCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/20.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMCommentModel;
@interface JMProductCommentCell : UITableViewCell
@property (nonatomic, strong)JMCommentModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
