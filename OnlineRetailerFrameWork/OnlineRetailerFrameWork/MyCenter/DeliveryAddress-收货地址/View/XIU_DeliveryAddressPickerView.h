//
//  XIU_DeliveryAddressPickerView.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/23.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIU_DeliveryAddressPickerViewDelegate <NSObject>

@required
- (void)clickedMaskView;
- (void)clickedLocationWithProvince:(NSString *)province city:(NSString *)city town:(NSString *)town;
@end

@interface XIU_DeliveryAddressPickerView : UIView

-(instancetype)initWithFrame:(CGRect)frame pickerDic:(NSDictionary *)pickerDic;
//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (nonatomic, assign) id<XIU_DeliveryAddressPickerViewDelegate> Delegate;

@end
