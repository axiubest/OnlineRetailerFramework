//
//  XIU_MyCenterGlobalEnum.h
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/8.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XIU_MyCenterGlobalEnum : NSObject

typedef NS_ENUM(NSInteger, PurchaseInformationStyle) {
    PurchaseInformationStyle_All,
    PurchaseInformationStyle_Pay,
    PurchaseInformationStyle_Send,
    PurchaseInformationStyle_Get,
    PurchaseInformationStyle_retund//退款
};

@end
