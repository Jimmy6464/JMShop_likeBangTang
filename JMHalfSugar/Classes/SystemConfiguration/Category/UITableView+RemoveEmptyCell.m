//
//  UITableView+RemoveEmptyCell.m
//  HD文华行
//
//  Created by Jimmy on 16/1/21.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "UITableView+RemoveEmptyCell.h"

@implementation UITableView (RemoveEmptyCell)
- (void)removeEmptyCellRows
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self setTableFooterView:view];
}
@end
