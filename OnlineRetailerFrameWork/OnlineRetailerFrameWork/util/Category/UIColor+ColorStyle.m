//
//  UIColor+ColorStyle.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/29.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "UIColor+ColorStyle.h"

@implementation UIColor (ColorStyle)

+(instancetype)xiu_randomColor {
    static UIColor *c = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    });
    return c;
    
}

+(instancetype)xiu_666color {
    static UIColor *c = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c =  [UIColor colorWithHexString:@"0x666666"];
    });
    return c;
}

+(instancetype)xiu_tableViewBackgroundColor {
    static UIColor *c = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c = [UIColor colorWithHexString:@"0xFFFFFF"];
    });
    return c;
}

+(instancetype)xiu_tableViewSectionBackgroundColor {
    static UIColor *c = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c = [UIColor colorWithHexString:@"0xF2F4F6"];
    });
    return c;
}
@end
