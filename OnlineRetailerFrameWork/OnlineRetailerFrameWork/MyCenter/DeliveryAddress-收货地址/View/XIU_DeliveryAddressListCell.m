//
//  XIUDeliveryAddressListCell.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/22.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_DeliveryAddressListCell.h"
#import "NSString+Common.h"
@interface XIU_DeliveryAddressListCell ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *deliveryPersonLab;

@property (weak, nonatomic) IBOutlet UILabel *diliveryPhoneNumberLab;

@property (weak, nonatomic) IBOutlet UILabel *diliveryDistrabtionAddressLab;

@property (weak, nonatomic) IBOutlet UIButton *selectDefaultButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIView *BottomView;

@end

@implementation XIU_DeliveryAddressListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self createBottomLine];
//    _diliveryDistrabtionAddressLab.font

}

- (CGFloat)CellHeightWithModel:(NSString *)string {
    CGFloat Height = _deliveryPersonLab.height + _deliveryPersonLab.y + _BottomView.height;
    return [string sizeWithLabelWidth:KWIDTH font:_diliveryDistrabtionAddressLab.font].height + Height;
}

- (void)setUpData:(NSString *)string {
    _diliveryDistrabtionAddressLab.text = string;
}

- (void)createBottomLine {
    CALayer *lineOfBottom = [[CALayer alloc] init];
    lineOfBottom.frame = CGRectMake(0, 0, KWIDTH, .5);
    lineOfBottom.backgroundColor = [UIColor lightGrayColor].CGColor;
    [_BottomView.layer addSublayer:lineOfBottom];
}
#pragma mark clicked delete button
- (IBAction)deleteButtonMethod:(UIButton *)sender {
    UIAlertView *delete = [[UIAlertView alloc] initWithTitle:@"确定要删除该地址吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [delete show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }else {
        //网络请求删除地址
        [_delegate deleteFunc];
    }
}

#pragma mark clicked edit button
- (IBAction)editButtonMethod:(id)sender {
    [_delegate editFunc];
}

- (IBAction)selectDefaultMethod:(id)sender {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
