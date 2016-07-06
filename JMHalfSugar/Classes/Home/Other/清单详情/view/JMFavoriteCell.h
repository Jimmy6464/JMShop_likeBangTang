//
//  JMFavoriteCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMFavoriteCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView title:(NSString *)title atIndexPath:(NSIndexPath *)indexPath;
@end
