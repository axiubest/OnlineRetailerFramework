//
//  XIU_CommodityDetailBaseController.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/2/8.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//
typedef NS_ENUM(NSInteger, CommodityDetailCellType) {
    CommodityDetailCellType_ProductInformation,
    CommodityDetailCellType_SelectTypeCell,
    CommodityDetailCellType_StoreInformation,
    CommodityDetailCellType_UserEvaluation
};



typedef NS_ENUM(NSInteger, ProductInformationCellType) {
    ProductInformationCellType_Share,
    ProductInformationCellType_Bargain,
    ProductInformationCellType_Discount
};

#import "XIU_HiddenTabBarController.h"



@interface XIU_CommodityDetailBaseController : XIU_HiddenTabBarController

@property (nonatomic, assign, readonly) CommodityDetailCellType CommodityDetailType;
@property (nonatomic, assign, readonly) ProductInformationCellType ProductInformationType;
@end
