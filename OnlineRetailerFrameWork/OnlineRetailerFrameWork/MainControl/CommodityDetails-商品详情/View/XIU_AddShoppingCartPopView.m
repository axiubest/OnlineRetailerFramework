//
//  XIU_AddShoppingCartPopView.m
//  Demo
//
//  Created by XIUDeveloper on 2017/2/7.
//  Copyright © 2017年 XIUDeveloper. All rights reserved.
//

#import "XIU_AddShoppingCartPopView.h"


#define LEFT_MARGIN 10
@interface XIU_AddShoppingCartPopView ()
{
    
}

@end

@implementation XIU_AddShoppingCartPopView

- (instancetype)initWithFrame:(CGRect)frame WithDataModel:(NSObject*)model {
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  =[UIColor whiteColor];
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44.f)];

        sureBtn.backgroundColor = [UIColor redColor];
        [sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(chcikedSureButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        
        
        [self createStaticHeaderView:frame];
  
    }
    return self;
}

- (void)createStaticHeaderView:(CGRect)frame {
    UIImageView *picImage = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, -40, 120, 120)];
    [picImage setImage:[UIImage imageNamed:@"1"]];
    [self setCornerRadius:5.f];
    [self addSubview:picImage];
    
 
    [self setUpLayerLineWithFrame:CGRectMake(LEFT_MARGIN, picImage.frame.size.height + picImage.frame.origin.y + 20, frame.size.width - 2 * LEFT_MARGIN, .5)];

}

- (void)setUpLayerLineWithFrame:(CGRect)frame {
    CALayer *line = [CALayer layer];
    line.frame = frame;
    line.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:line];

}
- (void)chcikedSureButton {
    
}
@end
