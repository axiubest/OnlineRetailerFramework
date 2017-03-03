//
//  XIU_ShoppingCartCalculationView.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ShoppingCartCalculationView.h"

static NSString *Bottom_UnSelectButtonString = @"cart_unSelect_btn";
static NSString *Bottom_SelectButtonString = @"cart_selected_btn";
static NSString *CartEmptyString = @"cart_default_bg";
static NSInteger selectallButtonSize = 25;

@interface XIU_ShoppingCartCalculationView ()


@end

@implementation XIU_ShoppingCartCalculationView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 0, KWIDTH, 1);
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        
        //全选按钮
        UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
        selectAll.titleLabel.font = [UIFont systemFontOfSize:16];


        [selectAll setImage:[UIImage imageNamed:Bottom_UnSelectButtonString] forState:UIControlStateNormal];
        [selectAll setImage:[UIImage imageNamed:Bottom_SelectButtonString] forState:UIControlStateSelected];
        [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectAll];
        self.allSellectedButton = selectAll;
        
        
        UILabel *selectAllBtn  =[[UILabel alloc] init];
        selectAllBtn.text = @"全选";
        selectAllBtn.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:selectAllBtn];
        
        
        //结算按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor orangeColor];
        btn.frame = CGRectMake(KWIDTH - 80, 0, 80, TabBarHeight);

        [btn setTitle:@"结 算" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        //合计
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor redColor];
        _priceLabel = label;
        [self addSubview:label];
        
        label.attributedText = [NSString SetStringOfShoppingCartPriceString:@"¥0.00"];
 

  
        
        
        [selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(selectallButtonSize, selectallButtonSize));
        }];
        
        
        [selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(selectAll.mas_right).with.offset(10);
            make.centerY.equalTo(self.mas_centerY);

        }];
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn.mas_left).with.offset(-10);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}


- (void)selectAllBtnClick:(UIButton *)sender {
    [_MyDelegate selectAllProduct:sender];
}

- (void)goToPayButtonClick:(UIButton *)sender {
    [_MyDelegate clickResultPrice];
}
@end
