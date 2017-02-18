//
//  XIU_ShoppingCart_GoodsModel.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XIU_ShoppingCart_GoodsModel : NSObject
{
    NSInteger _count;
    NSString *_goodsID, *_goodsName, *_price;
    NSString *_image;
}
@property (nonatomic,assign) BOOL select;

@property (assign,nonatomic)NSInteger count;
@property (copy,nonatomic)NSString *goodsID;
@property (copy,nonatomic)NSString *goodsName;
@property (copy,nonatomic)NSString *price;
@property (strong,nonatomic)NSString *image;
-(instancetype)initWithModel:(NSDictionary *)dic;



__attribute__((always_inline)) void setCount(void * obj, NSInteger  newCount);

__attribute__((always_inline)) void setGoodsID(void * obj, NSString* newGoodsID);

__attribute__((always_inline)) void setGoodsName(void * obj, NSString* newGoodsName);

__attribute__((always_inline)) void setPrice(void * obj, NSString* newPrice);

__attribute__((always_inline)) void setImage(void * obj, NSString* newImage);

@end
