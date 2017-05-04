//
//  XIU_MyCenterPurchaseInformationCell.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/8.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//
//用户购买信息cell
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PurchaseInformationStyle) {
    PurchaseInformationStyle_All,
    PurchaseInformationStyle_Pay,
    PurchaseInformationStyle_Send,
    PurchaseInformationStyle_Get,
    PurchaseInformationStyle_retund//退款
};

@protocol XIU_MyCenterPurchaseInformationDelegate <NSObject>

-(void)clickPurchaseInformationWithType:(PurchaseInformationStyle)type;

@end

@interface XIU_MyCenterPurchaseInformationCell : UITableViewCell

@property (nonatomic,assign)id<XIU_MyCenterPurchaseInformationDelegate>delegate;
@property (nonatomic, assign)PurchaseInformationStyle style;
@end
