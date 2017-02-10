//
//  XIU_CommodityDetialSelectTypeCell.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/2/8.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_CommodityDetialSelectTypeCell.h"

@implementation XIU_CommodityDetialSelectTypeCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self =  [ super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lab = [[UILabel alloc] init];
        [self.contentView addSubview:lab];
        lab.text = @"请选择型号";
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(10);
            make.top.and.bottom.equalTo(self.contentView).with.offset(0);
            make.width.offset(200);
        }];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
