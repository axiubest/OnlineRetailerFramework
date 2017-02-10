//
//  XIU_CommodityDetialBaseUserEvaluationCell.h
//  Demo
//
//  Created by XIUDeveloper on 16/6/4.
//  Copyright © 2016年 XIUDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>


#define XIU_CommodityDetialBaseStoreInformationIdentifier @"XIU_CommodityDetialBaseStoreInformationCell"
typedef void(^MerchandiseShopBasicInfoBlock)(NSInteger index);

@interface XIU_CommodityDetialBaseStoreInformationCell : UITableViewCell

@property (copy, nonatomic) MerchandiseShopBasicInfoBlock block;

@end
