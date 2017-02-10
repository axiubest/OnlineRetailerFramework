//
//  NSString+TextField.h
//  注册模块字符串判断封装
//
//  Created by A-XIU on 16/9/7.
//  Copyright © 2016年 XIU. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (TextField)

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
