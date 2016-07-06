//
//  JMAlbumsCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMAlbumsCell.h"

@interface JMAlbumsCell ()
@property (nonatomic, weak)UIImageView *imageView;

@end
@implementation JMAlbumsCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    self.layer.cornerRadius = 4.0;
    self.clipsToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    imageView.clipsToBounds = YES;
    imageView.contentMode  = UIViewContentModeCenter;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}
#pragma mark - ppublic method
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andImage:(UIImage *)image
{
    static NSString *reuseIdentifier = @"JMAlbumsCell";
    JMAlbumsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.image  = image;
    return cell;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    if (_image == nil) {
        self.imageView.image = [UIImage imageNamed:@"btn_library_camera"];
        return;
    }
    self.imageView.image = _image;
}
@end
