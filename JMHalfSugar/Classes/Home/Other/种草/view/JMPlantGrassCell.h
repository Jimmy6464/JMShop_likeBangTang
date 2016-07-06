//
//  JMPlantGrassCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/29.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMPlantGrassTeamModel;
@interface JMPlantGrassCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andModel:(JMPlantGrassTeamModel *)model;
@end
