//
//  UIView+Common.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/16.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

//剪切圆形，
- (void)doCircleFrame;

//添加圆角
- (void)setCornerRadius:(CGFloat)radius;

+ (UINib *)xiu_classNib;
@end
