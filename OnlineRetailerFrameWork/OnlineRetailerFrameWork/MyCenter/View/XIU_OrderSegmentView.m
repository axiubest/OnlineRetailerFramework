//
//  XIU_OrderSegmentView.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/4.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_OrderSegmentView.h"
#define OrderSegmentLineHeight 1

#define BottomLineHeight 2
@interface XIU_OrderSegmentView ()

@property (nonatomic, strong)CALayer *bottomLine;
@end
@implementation XIU_OrderSegmentView



-(CALayer *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [CALayer layer];
        _bottomLine.frame = CGRectMake(0, self.height - BottomLineHeight, 0, BottomLineHeight);
        _bottomLine.backgroundColor = [UIColor blueColor].CGColor;
        
    }
    return _bottomLine;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self.layer addSublayer:self.bottomLine];
}
- (IBAction)clickBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickSegmentType:)]) {
        [self.delegate clickSegmentType:sender.tag];
    }
    
    [self changeStyleOfButton:sender];
}

-(void)changeStyleOfButton:(UIButton *)sender {
    //如果抽出公用方法，在初始化传入按钮数组，根据按钮个数判断，在此为自定义，所以不必复用
    for (NSInteger i = 0; i < 5; i++) {

        UIButton *btn = (UIButton *)[self viewWithTag:i + 1000];
        
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

        if (btn.tag == sender.tag) {
            [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            self.bottomLine.frame = CGRectMake(KWIDTH/5 * i + 10, self.height - BottomLineHeight, KWIDTH/5-20, BottomLineHeight);
        }
    }

}

-(void)setStyle:(PurchaseInformationStyle)style {
    _style = style;
    UIButton *btn = (UIButton *)[self viewWithTag:_style + 1000];
    
    [self changeStyleOfButton:btn];

}

@end
