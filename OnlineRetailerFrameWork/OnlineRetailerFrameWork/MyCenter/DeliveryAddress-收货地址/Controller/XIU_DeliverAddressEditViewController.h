//
//  XIU_DeliverAddressEditViewController.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/22.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_HiddenTabBarController.h"
#import "XIU_DeliverAdderssModel.h"


//修改地址界面和添加地址界面
typedef NS_ENUM(NSInteger,DeliverAddressEditType) {
    DeliverAddressEditType_Person,
    DeliverAddressEditType_Phone,
    DeliverAddressEditType_Location,
    DeliverAddressEditType_Distribtion
};

static NSString *const XIU_DeliverAddressEditID = @"XIU_DeliverAddressEditViewController";
@interface XIU_DeliverAddressEditViewController : XIU_HiddenTabBarController

@property (nonatomic, assign) DeliverAddressEditType EditInformationType;




@property (nonatomic,strong) XIU_DeliverAdderssModel * model;

@end
