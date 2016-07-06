//
//  JMAuthor.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMAuthor : NSObject
/*
 *  useID
 */
@property (nonatomic, copy) NSString *user_id;
/*
 *  nickeName
 */
@property (nonatomic, copy) NSString *nickname;
/*
 *  avatar URL
 */
@property (nonatomic, copy) NSString *avatar;
/*
 *  isOfficial
 */
@property (nonatomic, copy) NSString *is_official;

+ (instancetype)authorWithDictionary:(NSDictionary *)dict;


@end
