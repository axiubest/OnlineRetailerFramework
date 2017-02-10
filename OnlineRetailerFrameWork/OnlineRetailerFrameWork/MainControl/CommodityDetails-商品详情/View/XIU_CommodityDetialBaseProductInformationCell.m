//
//  XIU_CommodityDetialBaseProductInformationCell.m
//  Demo
//
//  Created by XIUDeveloper on 16/6/4.
//  Copyright © 2016年 XIUDeveloper. All rights reserved.
//

#import "XIU_CommodityDetialBaseProductInformationCell.h"


@interface XIU_CommodityDetialBaseProductInformationCell ()

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *millisecondLabel;


@end

@implementation XIU_CommodityDetialBaseProductInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)merchandiseBasicInfoAction:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    if (self.block) {
        self.block(index);
    }
}

- (void)setEndTime:(NSString *)endTime {
    if(!endTime) return;
    _endTime = endTime;
    // 刷新时间
}

- (void)updateActivityDateWithComponent:(NSDateComponents *)component {
    if (self.isEnd) {
        component.hour = 0;
        component.minute = 0;
        component.second = 0;
        component.nanosecond = 0;
    }
    self.hourLabel.text = [NSString stringWithFormat:@"%02ld", (long)component.hour];
    self.minuteLabel.text = [NSString stringWithFormat:@"%02ld", (long)component.minute];
    self.secondLabel.text = [NSString stringWithFormat:@"%02ld", (long)component.second];
    self.millisecondLabel.text = [NSString stringWithFormat:@"%02ld", (long)component.nanosecond / 100000000];
//    NSLog(@"%ld", (long)component.nanosecond);
}


@end
