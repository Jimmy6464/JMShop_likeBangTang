//
//  JMAlbumsCell.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMAlbumsCell : UICollectionViewCell
@property (nonatomic, strong)UIImage *image;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andImage:(UIImage *)image;
@end
