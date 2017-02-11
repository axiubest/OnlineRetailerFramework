//
//  XIU_ShoppingCartCalculationView.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIU_ShoppingCartCalculationViewDelegate <NSObject>

@required
- (void)selectAllProduct:(UIButton *)sender;
- (void)clickResultPrice;

@end

@interface XIU_ShoppingCartCalculationView : UIView

@property (weak,nonatomic)UIButton *allSellectedButton;

@property (weak,nonatomic)UILabel *priceLabel;

@property (nonatomic, assign) id<XIU_ShoppingCartCalculationViewDelegate> MyDelegate;
@end
