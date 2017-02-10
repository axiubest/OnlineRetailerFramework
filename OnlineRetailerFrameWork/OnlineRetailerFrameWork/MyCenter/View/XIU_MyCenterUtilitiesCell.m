//
//  XIU_MyCenterUtilitiesCell.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/9.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

//实用工具Cell
#import "XIU_MyCenterUtilitiesCell.h"

#define LAYER_LINE_COLOR [UIColor lightGrayColor].CGColor

#define LAYER_LINE_HEIGHT 1
@interface XIU_MyCenterUtilitiesCell ()
{
    CALayer *_line1;
    CALayer *_line2;
    CALayer *_line3;

}
//标题View
@property (weak, nonatomic) IBOutlet UIView *HeaderView;

//工具详情View
@property (weak, nonatomic) IBOutlet UIView *UtilitiesView;
@end
@implementation XIU_MyCenterUtilitiesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CALayer *headerLine = [[CALayer alloc] init];
    headerLine.frame = CGRectMake(0, _HeaderView.height, KWIDTH, LAYER_LINE_HEIGHT);
    headerLine.backgroundColor = LAYER_LINE_COLOR;
    [_HeaderView.layer addSublayer:headerLine];
    
    [self SetUpLayerLineCALayer:_line1 WithFrame:CGRectMake(KWIDTH / 3, 0, LAYER_LINE_HEIGHT, _UtilitiesView.height)];
    [self SetUpLayerLineCALayer:_line2 WithFrame:CGRectMake(KWIDTH / 3 * 2, 0, LAYER_LINE_HEIGHT, _UtilitiesView.height)];
    [self SetUpLayerLineCALayer:_line3 WithFrame:CGRectMake(0, _UtilitiesView.height / 2, KWIDTH, LAYER_LINE_HEIGHT)];
    
}

- (void)SetUpLayerLineCALayer:(CALayer *)line WithFrame:(CGRect)frame {
    line = [[CALayer alloc] init];
    line.frame = frame;
    line.backgroundColor = LAYER_LINE_COLOR;
    [_UtilitiesView.layer addSublayer:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
