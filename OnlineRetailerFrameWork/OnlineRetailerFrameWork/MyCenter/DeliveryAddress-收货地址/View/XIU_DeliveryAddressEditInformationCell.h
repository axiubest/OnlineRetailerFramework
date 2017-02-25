//
//  XIU_DelieryAddressEditInformationCell.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/23.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIU_DeliveryAddressEditInformationCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UITextField *InformationTexfField;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString * Legitimate;
@end
