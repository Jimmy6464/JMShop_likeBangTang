//
//  JMPictureModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPictureModel.h"

@implementation JMPictureModel
- (void)setImageUrl:(NSString *)imageUrl
{
    if (imageUrl.length < 30 && imageUrl.length>0) {
        _imageUrl = [NSString stringWithFormat:@"http://bt.img.17gwx.com/%@",imageUrl];
    }else {
        _imageUrl = imageUrl;
    }
}
@end
