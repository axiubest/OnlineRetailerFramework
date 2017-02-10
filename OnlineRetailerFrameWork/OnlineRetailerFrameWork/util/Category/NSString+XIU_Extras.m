//
//  NSString+XIU_Extras.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/26.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "NSString+XIU_Extras.h"

@implementation NSString (XIU_Extras)

- (NSString *)xiu_substringAfterString:(NSString *)string {
    NSArray *components = [self componentsSeparatedByString:string];
    if ([components count] > 2) {
        return components[1];
    } else {
        return [components lastObject];
    }
}
@end
