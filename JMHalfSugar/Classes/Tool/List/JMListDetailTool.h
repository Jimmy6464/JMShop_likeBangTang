//
//  JMListDetailTool.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMListModel;
@interface JMListDetailTool : NSObject
+ (JMListModel *)createListModelWithListID:(NSString *)listID;
@end
