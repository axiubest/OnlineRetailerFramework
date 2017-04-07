//
//  UIView+Common.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/16.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "UIView+Common.h"
@implementation UIView (Common)

- (void)setCornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)doCircleFrame{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithHexString:@"0xDDDDDD"].CGColor;
}


#pragma mark DefaultNib
+ (UINib *)XIU_ClassNib {
    return [UINib nibWithNibName:[self XIU_NibName] bundle:nil];
}

+(NSString *)XIU_ClassIdentifier {
    return [self XIU_NibName];
}

+ (NSString *)XIU_NibName {
    /* Swift has "Namespaced" class names that prepend the module
     * For instance: "Wikipedia.MyCellClassName"
     * So we need to remove the "Wikipedia." for this to work
     */
    return [NSStringFromClass(self) xiu_substringAfterString:@"."];
}


@end
