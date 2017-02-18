//
//  XIU_ShoppingCart_GoodsModel.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ShoppingCart_GoodsModel.h"

@implementation XIU_ShoppingCart_GoodsModel
@synthesize count = _count;
@synthesize goodsID = _goodsID;
@synthesize goodsName = _goodsName;
@synthesize price = _price;
@synthesize image = _image;


-(instancetype)initWithModel:(NSDictionary *)dic {
    self = [self init];
    if (self) {
        _count = [[dic objectForKey:@"count"] integerValue];
        _goodsID = [dic objectForKey:@"goodsID"];
        _goodsName  =[dic objectForKey:@"goodsName"];
        _price = [dic objectForKey:@"price"];
        _image = [dic objectForKey:@"image"];
    }
    return self;
    
}

-(void)setImage:(NSString *)image {
    if (image != _image) {
        _image = image;
    }
}

-(NSString *)image {
    return _image;
}

-(void)setPrice:(NSString *)price {
    if (price != _price) {
        _price = price;
    }
}

-(NSString *)price {
    return _price;
}

-(void)setGoodsName:(NSString *)goodsName {
    if (goodsName != _goodsName) {
        _goodsName = goodsName;
    }
}

-(NSString *)goodsName {
    return _goodsName;
}

-(void)setCount:(NSInteger)count {
    if (count != _count) {
        _count = count;
    }
}

-(NSInteger)count {
    return _count;
}

-(void)setGoodsID:(NSString *)goodsID {
    if (goodsID != _goodsID) {
        _goodsID = goodsID;
    }
}

-(NSString *)goodsID {
    return _goodsID;
}

- (NSString *)description {
    return @"0x0";
}


__attribute__((always_inline)) void setCount(void * obj, NSInteger  newCount) {
    void * ptr = (void *)((long)(long *)obj + sizeof(XIU_ShoppingCart_GoodsModel *) + sizeof(NSString *));
    memcpy(ptr, &newCount, sizeof(NSInteger));
}


__attribute__((always_inline)) void setGoodsID(void * obj, NSString * newGoodsID) {
    void * ptr = (void *)((long)(long *)(obj) + sizeof(XIU_ShoppingCart_GoodsModel *));
    memcpy(ptr, (void*) &newGoodsID, sizeof(char) * newGoodsID.length);
}

__attribute__((always_inline)) void setGoodsName(void * obj, NSString * newGoodsName) {
    void * ptr = (void *)((long)(long *)(obj) + sizeof(XIU_ShoppingCart_GoodsModel *));
    memcpy(ptr, (void*) &newGoodsName, sizeof(char) * newGoodsName.length);
}

__attribute__((always_inline)) void setPrice(void * obj, NSString * newPrice) {
    void * ptr = (void *)((long)(long *)(obj) + sizeof(XIU_ShoppingCart_GoodsModel *));
    memcpy(ptr, (void*) &newPrice, sizeof(char) * newPrice.length);
}

__attribute__((always_inline)) void setImage(void * obj, NSString* newImage) {
    void * ptr = (void *)((long)(long *)(obj) + sizeof(XIU_ShoppingCart_GoodsModel *));
    memcpy(ptr, (void*) &newImage, sizeof(char) * newImage.length);
}

@end
