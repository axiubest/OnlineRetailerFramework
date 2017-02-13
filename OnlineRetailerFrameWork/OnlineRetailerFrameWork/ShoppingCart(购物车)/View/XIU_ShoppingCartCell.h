//
//  XIU_ShoppingCartShopCell.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.

#import <UIKit/UIKit.h>

@class XIU_ShoppingCart_GoodsModel;
static NSString *XIU_ShoppingCartShopCellIdentifier = @"XIU_ShoppingCartShopCellIdentifier";
typedef void(^NumberChangedBlock)(NSInteger number);
typedef void(^CellSelectedBlock)(BOOL select);
@interface XIU_ShoppingCartCell : UITableViewCell
//商品数量
@property (assign,nonatomic)NSInteger lzNumber;
@property (assign,nonatomic)BOOL isSelected;

- (void)reloadDataWithModel:(XIU_ShoppingCart_GoodsModel*)model;
- (void)numberAddWithBlock:(NumberChangedBlock)block;
- (void)numberCutWithBlock:(NumberChangedBlock)block;
- (void)cellSelectedWithBlock:(CellSelectedBlock)block;
@end
