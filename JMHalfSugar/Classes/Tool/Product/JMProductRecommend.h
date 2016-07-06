//
//  JMProductRecommend.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/6.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMProductRecommend : NSObject
- (NSMutableArray *)createProductRecommendModelAtCategoryIndex:(NSInteger)index;
- (NSMutableArray *)createDailyBannerModel;
@end
