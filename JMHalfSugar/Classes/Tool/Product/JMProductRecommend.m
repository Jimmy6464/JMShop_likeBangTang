//
//  JMProductRecommend.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/6.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductRecommend.h"
#import "JMProductRecommendModel.h"
#import "JMDailyBannerModel.h"
#import "JMCatergoryModel.h"
@interface JMProductRecommend ()
@property (nonatomic, strong) NSMutableArray *productArr;
@property (nonatomic, strong) NSMutableArray *categoryArr;
@property (nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) NSArray *jsonNameArray;
@end
@implementation JMProductRecommend
static NSDictionary *_dict = nil;
static NSString* _fileNmae = @"app_JSON";

- (NSMutableArray *)categoryArr
{
    if (!_categoryArr) {
        _categoryArr = [NSMutableArray new];
    }
    return _categoryArr;
}
- (NSMutableArray *)bannerArr
{
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray new];
    }
    return _bannerArr;
}
- (NSArray *)jsonNameArray
{
    if (!_jsonNameArray) {
        _jsonNameArray = @[@"app_JSON",@"json_Art",@"json_Gift",@"json_Guide",@"json_LoveBeauty",@"json_Design",@"json_Eater",@"json_Kitchen",@"json_WageEarners",@"json_Student",@"json_Party",@"json_Holiday",@"json_Dormitory"];
    }
    return _jsonNameArray;
}

#pragma mark - 
- (void)getDataFromJSONFileAtindex:(NSInteger)index
{
    _fileNmae = self.jsonNameArray[index];
    //get resource file
    NSString *path = [[NSBundle mainBundle] pathForResource:_fileNmae ofType:nil];
    NSLog(@"%@",path);
    NSData *data = [NSData dataWithContentsOfFile:path];
    _dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}
#pragma mark - 首页清单推荐模型---各种分类下的model
- (NSMutableArray *)createProductRecommendModelAtCategoryIndex:(NSInteger)index
{
    [self getDataFromJSONFileAtindex:index];
    //从json中解析出data数组
    NSDictionary *dataArr = [_dict objectForKey:@"data"];
    //从dataArr汇总解析出 topicArray
    NSArray *topicArray = [dataArr objectForKey:@"topic"];
    self.productArr = [NSMutableArray new];
    for (NSInteger i = 0; i < topicArray.count; i++) {
        id object = topicArray[i];
        //
        JMProductRecommendModel *productRecommend = [JMProductRecommendModel productRecommendWithDictionary:object];
        [self.productArr addObject:productRecommend];
    }
    return self.productArr;
}
#pragma mark - 创建首页轮播scrollView --每日精选
- (NSMutableArray *)createDailyBannerModel
{
    JMProductRecommend *product = [JMProductRecommend new];
    [product getDataFromJSONFileAtindex:0];
    
    NSDictionary *dataArr = [_dict objectForKey:@"data"];
    
    NSArray *bannerArr = [dataArr objectForKey:@"banner"];
    for (NSInteger i = 0; i < bannerArr.count; i++) {
        id object = bannerArr[i];
        JMDailyBannerModel *dailyBanner = [JMDailyBannerModel dailyBannerModelWithDictionary:object];
        [product.bannerArr  addObject:dailyBanner];
    }
    return product.bannerArr;
}
#pragma mark - 创建 分类模型 --"文艺" "设计" 等等
- (NSMutableArray *)createCategortyModel
{
    NSDictionary *dataArr = [_dict objectForKey:@"data"];
    
    NSArray *categoryArr = [dataArr objectForKey:@"category"];
    for (NSInteger i = 0; i < categoryArr.count; i++) {
        id object = categoryArr[i];
        JMCatergoryModel *dailyBanner = [JMCatergoryModel categroyWithDictionary:object];
        [self.categoryArr  addObject:dailyBanner];
    }
    return self.categoryArr;
}
@end
