//
//  NSString+XIU_Extras.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/26.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

- (NSString *)xiu_substringAfterString:(NSString *)string {
    NSArray *components = [self componentsSeparatedByString:string];
    if ([components count] > 2) {
        return components[1];
    } else {
        return [components lastObject];
    }
}


+ (NSMutableAttributedString*)SetStringOfShoppingCartPriceString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"合计:%@",string];
    NSMutableAttributedString *String = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"合计:"];
    [String addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [String addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return String;
}

- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font{
    NSDictionary *dict=@{NSFontAttributeName : font};
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}
@end
