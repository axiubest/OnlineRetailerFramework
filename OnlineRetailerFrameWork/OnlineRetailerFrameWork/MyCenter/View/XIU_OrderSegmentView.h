//
//  XIU_OrderSegmentView.h
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/4.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OrderSegmentStyle) {
    OrderSegmentStyle_all,
    OrderSegmentStyle_pay,
    OrderSegmentStyle_send,
    OrderSegmentStyle_get,
    OrderSegmentStyle_refund,
};

@protocol XIU_OrderSegmentDelegate <NSObject>

- (void)clickSegmentType:(OrderSegmentStyle)style;

@end

@interface XIU_OrderSegmentView : UIView
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *getBtn;
@property (weak, nonatomic) IBOutlet UIButton *refundBtn;
@property (nonatomic, assign) OrderSegmentStyle segmentStyle;
@property (nonatomic, assign)id<XIU_OrderSegmentDelegate>delegate;
@end
