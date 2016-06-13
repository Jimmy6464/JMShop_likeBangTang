//
//  JMSearchTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchTool.h"
#import "JMSearchModel.h"
#import "JMSerchLishModel.h"
@implementation JMSearchTool
+ (NSMutableArray *)createSearchModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"搜索列表" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //json to dictionary
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataArr = [dict objectForKey:@"data"];
    NSMutableArray *searchArr = [NSMutableArray array];
    for (NSInteger i = 0; i < dataArr.count; i++) {
        JMSearchModel *searchModel = [JMSearchModel searchModelWithDictionary:dataArr[i]];
        [searchArr addObject:searchModel];
    }
    /*
     let path = NSBundle.mainBundle().pathForResource("搜索列表", ofType: nil)
     let nsData = NSData(contentsOfFile: path!)
     /// json整体转换为字典
     let Dict = ( try! NSJSONSerialization.JSONObjectWithData(nsData!, options:.AllowFragments) ) as! NSDictionary
     let data = Dict.objectForKey("data") as? NSArray
     
     var searchArr = [SearchModel]()
     
     for var i = 0 ; i < data?.count ; i++ {
     
     let model = SearchModel()
     let obj = data![i] as! NSDictionary
     model.categoryID = obj.objectForKey("id") as? String
     model.name = obj.objectForKey("name") as? String
     model.en_name = obj.objectForKey("en_name") as? String
     model.iconUrl = obj.objectForKey("icon") as? String
     
     //二级分类
     let subListData = obj.objectForKey("subclass") as? NSArray
     
     model.subList = [SearchModel]()
     for var i = 0 ; i < subListData?.count ; i++
     {
     let subListModel = SearchModel()
     let subObj = subListData![i] as! NSDictionary
     
     subListModel.categoryID = subObj.objectForKey("id") as? String
     subListModel.name = subObj.objectForKey("name") as? String
     subListModel.en_name = ""
     subListModel.iconUrl = subObj.objectForKey("icon") as? String
     //二级分类下没有 三级分类了 先置空
     subListModel.subList = nil
     
     model.subList?.append(subListModel)
     }
     searchArr.append(model)
     }
     return searchArr
     */
    return searchArr;
}
+ (NSMutableArray *)createSearchListModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"搜索清单" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //json to dictionary
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataArr = [dict objectForKey:@"data"];
    NSMutableArray *searchArr = [NSMutableArray array];
    for (NSInteger i = 0; i < dataArr.count; i++) {
        JMSerchLishModel *model = [JMSerchLishModel searchListModelWithDictionary:dataArr[i]];
        [searchArr addObject:model];
    }
    return searchArr;
    
    return nil;
}
@end
