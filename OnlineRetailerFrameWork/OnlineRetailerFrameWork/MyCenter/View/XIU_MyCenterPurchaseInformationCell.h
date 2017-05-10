//
//  XIU_MyCenterPurchaseInformationCell.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/8.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//
//用户购买信息cell
#import <UIKit/UIKit.h>
#import "XIU_MyCenterGlobalEnum.h"



@protocol XIU_MyCenterPurchaseInformationDelegate <NSObject>

-(void)clickPurchaseInformationWithType:(PurchaseInformationStyle)type;

@end

@interface XIU_MyCenterPurchaseInformationCell : UITableViewCell

@property (nonatomic,assign)id<XIU_MyCenterPurchaseInformationDelegate>delegate;
@property (nonatomic, assign)PurchaseInformationStyle style;

@end
