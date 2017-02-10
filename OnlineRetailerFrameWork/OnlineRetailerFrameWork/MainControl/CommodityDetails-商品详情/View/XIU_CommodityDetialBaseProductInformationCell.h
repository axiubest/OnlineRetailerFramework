//
//  XIU_CommodityDetialBaseProductInformationCell.h
//  Demo
//
//  Created by XIUDeveloper on 16/6/4.
//  Copyright © 2016年 XIUDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XIU_CommodityDetialBaseProductInformationIdentifier @"XIU_CommodityDetialBaseProductInformationCell"

typedef void(^MerchandiseBasicInfoBlock)(NSInteger index);

@interface XIU_CommodityDetialBaseProductInformationCell : UITableViewCell

@property (copy, nonatomic) MerchandiseBasicInfoBlock block;

@property (copy, nonatomic) NSString *endTime;    // 活动结束时间

@property (assign, nonatomic) BOOL isEnd;   // 活动是否结束

// 更新活动结束时间
- (void)updateActivityDateWithComponent:(NSDateComponents *)component;

@end
