//
//  JMMoveToMyFavoriteViw.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMMoveToMyFavoriteViwDelegate <NSObject>

- (void)createANewList;

@end
@interface JMMoveToMyFavoriteViw : UIView
@property (nonatomic, assign) id <JMMoveToMyFavoriteViwDelegate> delegate;
- (void)showWithAnimation:(NSString *)productID;
@end
