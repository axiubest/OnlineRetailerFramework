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

@property (nonatomic,assign) BOOL select;

@property (assign,nonatomic)NSInteger count;
@property (copy,nonatomic)NSString *goodsID;
@property (copy,nonatomic)NSString *goodsName;
@property (copy,nonatomic)NSString *price;
@property (strong,nonatomic)UIImage *image;

@end
