//
//  XIUDeliveryAddressListCell.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/22.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIU_DeliveryAddressListCellDelegate <NSObject>

@required
- (void)deleteFunc;
- (void)editFunc;

@end

@interface XIU_DeliveryAddressListCell : UITableViewCell

@property (nonatomic, assign) id<XIU_DeliveryAddressListCellDelegate> delegate;
- (void)setUpData:(NSString *)string;

- (CGFloat)CellHeightWithModel:(NSString *)string;
@end
