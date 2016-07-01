//
//  JMPersonCenterActivityCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/7/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMUserRecommendModel;
@interface JMPersonCenterActivityCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andModel:(JMUserRecommendModel *)model;
@end
