//
//  XIU_ShoppingCartHeaderView.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>


static  NSString* XIU_ShoppingCartHeaderViewIdentifier  = @"XIU_ShoppingCartHeaderViewIdentifier";

typedef void(^buttonClickBlock)(BOOL select);
@interface XIU_ShoppingCartHeaderView : UITableViewHeaderFooterView

@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)buttonClickBlock ClickBlock;
@property (assign,nonatomic)BOOL select;
@end
