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

//1. 整形判断
+ (BOOL)isPureInt:(NSString *)string;

//2.浮点形判断：
+ (BOOL)isPureFloat:(NSString *)string;

//3.手机号码格式判断
+ (BOOL)valiMobile:(NSString *)mobile;

//4.判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;

//5.判断字符串是否包含特殊字符
+(BOOL)isIncludeSpecialCharact: (NSString *)str;

//判断密码
+(BOOL)checkPassWord:(NSString *)password;


@end
