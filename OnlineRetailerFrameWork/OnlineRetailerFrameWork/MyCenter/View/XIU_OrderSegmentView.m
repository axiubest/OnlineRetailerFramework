//
//  XIU_OrderSegmentView.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/4.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_OrderSegmentView.h"
#define OrderSegmentLineHeight 1

@interface XIU_OrderSegmentView ()

@property (nonatomic, weak)CALayer *bottomLine;
@end
@implementation XIU_OrderSegmentView



-(void)awakeFromNib {
    [super awakeFromNib];

}

- (IBAction)clickBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickSegmentType:)]) {
        [self.delegate clickSegmentType:sender.tag];
    }
    
    //如果抽出公用方法，在初始化传入按钮数组，根据按钮个数判断，在此为自定义，所以不必复用
    for (int i = 0; i < 5; i++) {
        if (sender.tag == i) {
            [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }else {
            [sender setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
    }
    switch (sender.tag) {
        case OrderSegmentStyle_all:
            
            break;
        case OrderSegmentStyle_get:
            
            break;
        case OrderSegmentStyle_send:
            
            break;
        case OrderSegmentStyle_pay:
            
            break;
        case OrderSegmentStyle_refund:
            
            break;
            
        default:
            break;
    }
}

-(void)setSegmentStyle:(OrderSegmentStyle)segmentStyle {
    _segmentStyle = segmentStyle;
    
}

@end
