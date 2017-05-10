//
//  XIU_MyCenterPurchaseInformationCell.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/8.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//
//用户购买信息cell
#import "XIU_MyCenterPurchaseInformationCell.h"
#import "UIImageView+Badge.h"

static NSInteger heightOfMyPurchase = 30;
@interface XIU_MyCenterPurchaseInformationCell ()
{
    
}
@property (weak, nonatomic) IBOutlet UIView *AllOrdersView;
@property (weak, nonatomic) IBOutlet UIView *PayView;
@property (weak, nonatomic) IBOutlet UIView *SendView;
@property (weak, nonatomic) IBOutlet UIView *GetView;
@property (weak, nonatomic) IBOutlet UIView *RefundView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AllOrdersViewHeightConstraint; //我的订单高度


@property (weak, nonatomic) IBOutlet UIImageView *WaitPayImageView;

@property (weak, nonatomic) IBOutlet UIImageView *WaitSendImageView;

@property (weak, nonatomic) IBOutlet UIImageView *WaitGetImageView;

@property (weak, nonatomic) IBOutlet UIImageView *WaitEvaluateImageView;



@end
@implementation XIU_MyCenterPurchaseInformationCell
@synthesize style;

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setUpCellUI];
    [_AllOrdersView bk_whenTapped:^{
        style = PurchaseInformationStyle_All;
        [self clickWithStyle:style];
    }];
    [_GetView bk_whenTapped:^{
        style = PurchaseInformationStyle_Get;
        [self clickWithStyle:style];
    }];
    [_SendView bk_whenTapped:^{
        style = PurchaseInformationStyle_Send;
        [self clickWithStyle:style];
    }];
    [_PayView bk_whenTapped:^{
        style = PurchaseInformationStyle_Pay;
        [self clickWithStyle:style];
    }];
    [_RefundView bk_whenTapped:^{
        style = PurchaseInformationStyle_retund;
        [self clickWithStyle:style];
    }];
    
}

- (void)clickWithStyle:(PurchaseInformationStyle)type {
    
    if ([self.delegate respondsToSelector:@selector(clickPurchaseInformationWithType:)]) {
        [self.delegate clickPurchaseInformationWithType:type];
    }
}

- (void)setUpCellUI {
    _AllOrdersViewHeightConstraint.constant =heightOfMyPurchase;
    CALayer *bottomLayer = [[CALayer alloc] init];
    bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    bottomLayer.frame = CGRectMake(0, _AllOrdersViewHeightConstraint.constant - 1, KWIDTH, 1);
    [_AllOrdersView.layer addSublayer:bottomLayer];
    
    
    _WaitSendImageView.badgeValue = @"1";
    _WaitEvaluateImageView.badgeValue = @"999";

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
