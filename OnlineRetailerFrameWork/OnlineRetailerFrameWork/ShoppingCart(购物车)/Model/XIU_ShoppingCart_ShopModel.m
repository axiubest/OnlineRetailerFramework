//
//  LZShopModel.m
//  LZCartViewController
//
//  Created by Artron_LQQ on 16/5/31.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "XIU_ShoppingCart_ShopModel.h"
#import "XIU_ShoppingCart_GoodsModel.h"

@implementation XIU_ShoppingCart_ShopModel

- (void)configGoodsArrayWithArray:(NSArray*)array; {
    if (array.count > 0) {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            XIU_ShoppingCart_GoodsModel *model = [[XIU_ShoppingCart_GoodsModel alloc]init];
            
            model.count = [[dic objectForKey:@"count"] integerValue];
            model.goodsID = [dic objectForKey:@"goodsId"];
            model.goodsName = [dic objectForKey:@"goodsName"];
            model.price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"realPrice"]];
            model.image = [dic objectForKey:@"goodsImage"];
            [dataArray addObject:model];
        }
        
        _goodsArray = [dataArray mutableCopy];
    }
}
@end
