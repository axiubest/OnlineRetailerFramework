//
//  XIU_DeliveryAddressEditLocationCell.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/23.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_DeliveryAddressEditLocationCell.h"


static NSString * const EditLocation_SelectLocation = @"请选择所在地区";
@interface XIU_DeliveryAddressEditLocationCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation XIU_DeliveryAddressEditLocationCell



-(NSString *)Legitimate {
    if (!(_locationLabel.text.length > 0)) {
        [self alertViewWithString:EditLocation_SelectLocation];
        return nil;
    }
    return _locationLabel.text;
}

//-(void)setIndexPath:(NSIndexPath *)indexPath {
//    _indexPath = indexPath;
//    if (_indexPath.section == 0 && indexPath.row == 3) {
//        _titleLabel.text = @"街道";
//    }
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
