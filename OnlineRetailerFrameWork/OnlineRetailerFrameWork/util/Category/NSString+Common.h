//
//  NSString+XIU_Extras.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/26.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

- (NSString *)xiu_substringAfterString:(NSString *)string;

+ (NSMutableAttributedString*)SetStringOfShoppingCartPriceString:(NSString*)string;


//cell height math
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;


@end
