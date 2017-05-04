//
//  XIU_OrderSegmentView.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/4.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_OrderSegmentView.h"
#define OrderSegmentLineHeight 1
@implementation XIU_OrderSegmentView

-(void)awakeFromNib {
    [super awakeFromNib];
    CALayer *bottomLine = [CALayer layer];
    bottomLine.backgroundColor = [UIColor lightGrayColor].CGColor;
    bottomLine.frame = CGRectMake(0, self.height - OrderSegmentLineHeight, self.width, OrderSegmentLineHeight);
    [self.layer addSublayer:bottomLine];
    
}

@end
