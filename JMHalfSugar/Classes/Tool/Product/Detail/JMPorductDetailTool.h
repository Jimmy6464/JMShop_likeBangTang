//
//  JMPorductDetailTool.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMProductDetailModel;
@interface JMPorductDetailTool : NSObject
+ (JMProductDetailModel *)createProductDetailModel;
+ (NSMutableArray *)createCommentList:(NSArray *)commentData;
@end
