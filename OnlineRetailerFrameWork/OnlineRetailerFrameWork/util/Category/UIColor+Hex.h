//
//  UIColor+Hex.h
//  CHISLIM
//
//  Created by XIUDeveloper on 2016/11/25.
//  Copyright © 2016年 XIU. All rights reserved.
//

struct RGBcolor {
    int red;
    int green;
    int blue;
};
typedef struct RGBcolor rgbColor;

#import <UIKit/UIKit.h>


@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


+ (UIColor *)colorWithRGB:(rgbColor )color;
@end
