//
//  XIU_DeliveryAddressEditLocationCell.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/23.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIU_DeliveryAddressEditLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;


/**
 参数合法性检测
 */
@property (nonatomic, copy) NSString * Legitimate;

//添加街道cell可解复用
//@property (nonatomic, strong) NSIndexPath *indexPath;

@end
