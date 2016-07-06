//
//  JMBannerView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

enum ClickType{
    GoodThingClickType,
    SearchClickType,
    PlantGrassClickType,
    SignInClickType
};
@protocol JMBannerViewDelegate <NSObject>
- (void)bannerButtonClickeWithType:(enum ClickType)clickType;
@end
@interface JMBannerView : UIView
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, weak) id <JMBannerViewDelegate> delegate;
@end
