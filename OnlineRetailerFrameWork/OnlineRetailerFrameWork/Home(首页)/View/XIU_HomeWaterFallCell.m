//
//  XIU_HomeWaterFallCell.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/22.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_HomeWaterFallCell.h"

@implementation XIU_HomeWaterFallCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _image  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _image.backgroundColor = [UIColor grayColor];
        [self addSubview:_image];
    }
    return self;
}

-(void)setModel:(XIU_HomeWaterFallModel *)model
{
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:_model.img]];
}
@end
