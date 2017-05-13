//
//  XIU_ConfirmPayAddressCell.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ConfirmPayAddressCell.h"

@interface XIU_ConfirmPayAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *consigneeLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@end

@implementation XIU_ConfirmPayAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
