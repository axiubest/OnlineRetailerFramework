//
//  XIU_DelieryAddressEditInformationCell.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/23.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_DeliveryAddressEditInformationCell.h"

static NSString * const recipientInfo_tooShort = @"收货人姓名至少2个字符";
static NSString * const recipientInfo_tooLong = @"收货人姓名小于15个字符";
static NSString * const recipientInfo_wrongPhoneNum = @"请输入正确11位手机号";
@implementation XIU_DeliveryAddressEditInformationCell



//信息校验
-(NSString *)Legitimate {
    
        if (self.indexPath.section == 0 && self.indexPath.row == 0) {
            if (_InformationTexfField.text.length < 3) {
                [self alertViewWithString:recipientInfo_tooShort];
                return nil;
            }if (_InformationTexfField.text.length > 16) {
                 [self alertViewWithString:recipientInfo_tooLong];
                return nil;
            }

            return _InformationTexfField.text;
            
        }if (self.indexPath.section == 0 && self.indexPath.row == 1) {
            if (![NSString valiMobile:_InformationTexfField.text]) {
                [self alertViewWithString:recipientInfo_wrongPhoneNum];
                return nil;
            }
        }
    return _InformationTexfField.text;
}



-(void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath=indexPath;
    {
                NSInteger row = _indexPath.row;
                NSInteger section = _indexPath.section;
                if (section == 0 && row == 0) {
                    _titleLabel.text = @"收货人";
                    _InformationTexfField.placeholder = @"请输入收货人姓名";
                }if (section == 0 && row == 1) {
                    _titleLabel.text = @"联系电话";
                    _InformationTexfField.placeholder = @"请输入电话号码";
                }if (section == 1) {
                    _titleLabel.text = @"设为默认";
                    [self addSliderview];
                    _InformationTexfField.hidden = YES;
                }if (section == 2) {
                    _titleLabel.text = @"删除地址";
                    _titleLabel.textColor = [UIColor redColor];
                    _InformationTexfField.hidden = YES;
                }
            }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)addSliderview {
    UISwitch *switchView = [[UISwitch alloc] init];
    [switchView addTarget:self action:@selector(switchMethod) forControlEvents:UIControlEventTouchUpInside];
    switchView.on = YES;
    [self.contentView addSubview:switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-20);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)switchMethod {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
