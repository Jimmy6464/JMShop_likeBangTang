//
//  JMCommon.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/5/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#define JMKeyWindow [UIApplication sharedApplication].keyWindow
#define JMDeviceWidth     [UIScreen mainScreen].bounds.size.width
#define JMDeviceHeight     [UIScreen mainScreen].bounds.size.height
#define JMColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define PlaceHolderImage @"placeHolder.jpg"
#define JMSubTitleColor JMColor(153,153,153)
#define JMMainTitleColor JMColor(109,109,109)

#define JMCustomBarTintColor [UIColor colorWithHexString:@"EC5252"]
#define JMGrayLineColor [UIColor colorWithHexString:@"D8D8D8"]
#define JMTitleGrayColor [UIColor colorWithHexString:@"A7A7A7"]
#define JMPlaceHolderColor [UIColor colorWithHexString:@"B6B6B6"]
#define JMViewGrayBackgroundColor [UIColor colorWithHexString:@"F5F5F5"]
#define JMHalfBlackTitleColor [UIColor colorWithHexString:@"959595"]
#define JMLightLineColor [UIColor colorWithHexString:@"F9F9F9"]

#define ThinFont @"PingFangSC-Thin"
#define LightFont @"PingFangSC-Light"
#define RegularFont @"PingFangSC-Regular"

#define JMNotificationCenter [NSNotificationCenter defaultCenter]
#define JMChangeGender @"ChangeGender"
#define JMChangeAvatar @"JMChangeAvatar"
#define JMOpenTheCamera @"JMOpenTheCamera"

