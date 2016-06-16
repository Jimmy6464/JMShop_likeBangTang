//
//  JMInventoryView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/14.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMSearchModel;

@protocol JMINventoryViewDelegate <NSObject>

- (void)didSelectedItem:(NSIndexPath *)indexPath;

@end
@interface JMInventoryView : UIView
@property (nonatomic, strong) NSMutableArray<JMSearchModel *> *categoryModel;
@property (nonatomic, weak) id<JMINventoryViewDelegate> delegate;

@end
