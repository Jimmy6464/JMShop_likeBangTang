//
//  JMListDetailCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/22.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMListDetailProductModel;
typedef enum : NSUInteger {
    AllowComment_type = 1100,
    NotAllowComment_type = 1110,
    //
    LikeIt_type,
    MoveToOtherFavoriteList_type,
    //
    BuyThisProduct_type,
    //
    ShareProduct_type,
} ListDetailCellClickType;

@protocol JMListDetailCellDelegate <NSObject>

//check the details of product
- (void)checkProductDetails:(NSInteger)productID;
- (void)clickCenterWithType:(ListDetailCellClickType)clickType atIndexPath:(NSIndexPath *)indexPath;
@end
@interface JMListDetailCell : UITableViewCell
@property (nonatomic, weak ) id<JMListDetailCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(JMListDetailProductModel *)model;
@end
