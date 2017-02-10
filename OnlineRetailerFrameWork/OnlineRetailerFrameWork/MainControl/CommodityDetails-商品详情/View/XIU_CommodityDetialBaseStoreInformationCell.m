//
//  XIU_CommodityDetialBaseUserEvaluationCell.m
//  Demo
//
//  Created by XIUDeveloper on 16/6/4.
//  Copyright © 2016年 XIUDeveloper. All rights reserved.
//

#import "XIU_CommodityDetialBaseStoreInformationCell.h"


@interface XIU_CommodityDetialBaseStoreInformationCell ()

@property (weak, nonatomic) IBOutlet UIButton *shopCategoryButton;
@property (weak, nonatomic) IBOutlet UIButton *shopDetailButton;

@end

@implementation XIU_CommodityDetialBaseStoreInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shopCategoryButton.layer.borderColor = [UIColor colorWithRed:1.000 green:0.482 blue:0.275 alpha:1.000].CGColor;
    self.shopDetailButton.layer.borderColor = [UIColor colorWithRed:1.000 green:0.482 blue:0.275 alpha:1.000].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)merchandiseShopBasicInfoAction:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    if (self.block) {
        self.block(index);
    }
}

@end
