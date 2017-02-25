//
//  XIU_DeliveryAddressEditDestribtionLocCell.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/23.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_DeliveryAddressEditDestribtionLocCell.h"


static NSString * const EditDestribtionLoc_tooShort = @"请填写详细地址";

static NSString * const EditDestribtionLoc_tooLong = @"地址输入不得超过60个字符";
@interface XIU_DeliveryAddressEditDestribtionLocCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *TextView;

@property (weak, nonatomic) IBOutlet UILabel *placeHolderLab;

@end

@implementation XIU_DeliveryAddressEditDestribtionLocCell


-(NSString *)Legitimate {
    if (!(_TextView.text.length > 6)) {
        [self alertViewWithString:EditDestribtionLoc_tooShort];
        return nil;
    }if (_TextView.text.length > 60) {
        [self alertViewWithString:EditDestribtionLoc_tooLong];
        return nil;
    }
    return _TextView.text;
}

- (void)awakeFromNib {
    [super awakeFromNib];

        [[NSNotificationCenter defaultCenter] addObserver:self
         selector:@selector(keyboardWasShown:)
             name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
    

}



- (void)keyboardWasShown:(NSNotification *)notification {
    _placeHolderLab.hidden = YES;
}

- (void)keyboardWasHidden:(NSNotification *)notification {
    _placeHolderLab.hidden = _TextView.text.length > 0 ? YES : NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
