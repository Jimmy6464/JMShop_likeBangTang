//
//  JMUserRecommendTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMUserRecommendTool.h"
#import "JMUserRecommendModel.h"
@implementation JMUserRecommendTool
+ (NSArray *)createUserRecommendModelWithListID:(NSString *)listID
{
    if (![listID isEqualToString:@"1872"]) {
        return nil;
    }else {
        NSMutableArray *userRecommendArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"用户推荐" ofType:nil];
        NSData *JSONData = [NSData dataWithContentsOfFile:path];
        //json to dictionary
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *data = dict[@"data"];
        
        NSArray *list = data[@"list"];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMUserRecommendModel *model = [JMUserRecommendModel userRecommendWithDictionary:obj];
            [userRecommendArray addObject:model];
        }];
        return userRecommendArray;
        
    }
    /*
     if(listID != "1872")
     {
     TipView.showMessage("这个清单名字太烂，没抓包😄")
     return nil
     }else{
     var userRecommendArray = [UserRecommendModel]()
     
     let path = NSBundle.mainBundle().pathForResource("用户推荐", ofType: nil)
     let nsData = NSData(contentsOfFile: path!)
     /// json整体转换为字典
     let Dict = ( try! NSJSONSerialization.JSONObjectWithData(nsData!, options:.AllowFragments) ) as! NSDictionary
     
     let data = Dict.objectForKey("data") as! NSDictionary
     
     let list = data.objectForKey("list") as! NSArray
     
     print("用户推荐中共有 \(list.count)")
     
     for var i = 0; i < list.count ; i++ {
     let obj = list[i]
     let recommendModel = UserRecommendModel()
     recommendModel.userRecommendID = obj.objectForKey("id") as? String
     recommendModel.title = obj.objectForKey("title") as? String
     recommendModel.content = obj.objectForKey("content") as? String
     recommendModel.author_id = obj.objectForKey("author_id") as? String
     recommendModel.share_url = obj.objectForKey("share_url") as? String
     recommendModel.createTime = obj.objectForKey("datestr") as? String
     
     //作者
     let authorDict = obj.objectForKey("author") as! NSDictionary
     recommendModel.author = Author.createAutor(authorDict)
     
     //picArray
     let picData = obj.objectForKey("pics") as! NSArray
     recommendModel.picArray = UserRecommendPicModel.createPicArray(picData)
     
     //tags
     let tagData = obj.objectForKey("tags") as! NSArray
     recommendModel.tagArray = UserRecommendTags.createTagArray(tagData)
     
     //dynamic
     let dynamicData = obj.objectForKey("dynamic") as! NSDictionary
     recommendModel.dynamic = UserRecommendDynamic.createUserRecommendDynamic(dynamicData)
     
     //product
     let productData = obj.objectForKey("product") as! NSArray
     recommendModel.productArray = UserRecommendProductModel.createProductArray(productData)
     
     userRecommendArray.append(recommendModel)
     }
     
     return userRecommendArray
     
     }
     

     */
    return nil;
}
@end
