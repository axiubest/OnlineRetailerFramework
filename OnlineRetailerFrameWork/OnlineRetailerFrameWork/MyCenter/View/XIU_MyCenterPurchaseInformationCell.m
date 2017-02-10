//
//  XIU_MyCenterPurchaseInformationCell.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/8.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//
//用户购买信息cell
#import "XIU_MyCenterPurchaseInformationCell.h"

@interface XIU_MyCenterPurchaseInformationCell ()

@property (weak, nonatomic) IBOutlet UIView *AllOrdersView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AllOrdersViewHeightConstraint;

@end

@implementation XIU_MyCenterPurchaseInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpCellUI];
    
}

- (void)setUpCellUI {
    _AllOrdersViewHeightConstraint.constant =30;
    CALayer *bottomLayer = [[CALayer alloc] init];
    bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    bottomLayer.frame = CGRectMake(0, _AllOrdersViewHeightConstraint.constant - 1, KWIDTH, 1);
    [_AllOrdersView.layer addSublayer:bottomLayer];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
