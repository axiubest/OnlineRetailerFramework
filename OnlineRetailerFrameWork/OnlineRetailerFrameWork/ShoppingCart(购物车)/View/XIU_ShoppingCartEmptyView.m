//
//  XIU_EmptyView.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ShoppingCartEmptyView.h"

@implementation XIU_ShoppingCartEmptyView

-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title ImageName:(NSString *)imageName {
    self = [super initWithFrame:frame];
    if (self) {
        //默认图片
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart_default_bg"]];
        img.center = CGPointMake(KWIDTH/2.0, KHEIGHT/2.0 - 120);
        img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
        [self addSubview:img];
        
        UILabel *warnLabel = [[UILabel alloc]init];
        warnLabel.center = CGPointMake(KWIDTH/2.0, KHEIGHT/2.0 - 10);
        warnLabel.bounds = CGRectMake(0, 0, KWIDTH, 30);
        warnLabel.textAlignment = NSTextAlignmentCenter;
        warnLabel.text = title;
        warnLabel.font = [UIFont systemFontOfSize:15];
        warnLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:warnLabel];
    }
    return self;
}

@end
