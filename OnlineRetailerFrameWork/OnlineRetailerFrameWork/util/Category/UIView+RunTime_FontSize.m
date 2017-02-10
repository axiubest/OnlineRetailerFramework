//
//  UIView+RunTime_FontSize.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/9.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

//全局修改字体

//888预留tag不作修改
#define DeviceTypeOf4_5 320
#define DeviceTypeOf6 375
#define DeviceTypeOfPlus 540

#define IgnoreTagKey @"IgnoreTagKey"
#define FontScaleKey @"FontScaleKey"

#import "UIView+RunTime_FontSize.h"
#import <objc/runtime.h>


@implementation UIView (RunTime_FontSize)

-(CGFloat)screenSize {
    
    if (KWIDTH == DeviceTypeOf4_5) {
        return 11.f;
    }if (KWIDTH == DeviceTypeOf6) {
        return 12.f;
        
    }if (KWIDTH == DeviceTypeOfPlus) {
        return 12.f;
    }else {
        return 14.f;
    }
}

/**
 设置需要忽略的空间tag值
 
 @param tagArr tag值数组
 */
+ (void)setIgnoreTags:(NSArray<NSNumber*> *)tagArr{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tagArr forKey:IgnoreTagKey];
    [defaults synchronize];
}

+ (NSArray *)getIgnoreTags{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *ignoreTagsArr = [defaults objectForKey:IgnoreTagKey];
    return ignoreTagsArr.count?ignoreTagsArr:0;
}
@end

@interface UILabel (FontSize)

@end

@interface UIButton (FontSize)

@end

@interface UITextField (FontSize)

@end

@interface UITextView (FontSize)

@end


#pragma mark UILabel
@implementation UILabel (FontSize)

+ (void)load{
    if(!UILabelEnable) return;
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        //        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
        //        NSArray *ignoreTags = [UIView getIgnoreTags];
        //        for (NSNumber *num in ignoreTags) {
        //            if(self.tag == num.integerValue) return self;
        //        }
        if (self.tag == 888) {
            return self;
        }
        self.font = [self.font fontWithSize:[self screenSize]];

    }
    return self;
}


- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        //        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
        //        NSArray *ignoreTags = [UIView getIgnoreTags];
        //        for (NSNumber *num in ignoreTags) {
        //            if(self.tag == num.integerValue) return self;
        //        }
        if (self.tag == 888) {
            return self;
        }
        self.font = [self.font fontWithSize:[self screenSize]];
    }
    return self;
}
@end

#pragma mark UIButton
@implementation UIButton (FontSize)

+ (void)load {
    if(!UIButtonEnable) return;
    
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }

        self.titleLabel.font = [self.titleLabel.font fontWithSize:[self screenSize]];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        //        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
        //        NSArray *ignoreTags = [UIView getIgnoreTags];
        //        for (NSNumber *num in ignoreTags) {
        //            if(self.tag == num.integerValue) return self;
        //        }

        self.titleLabel.font = [self.titleLabel.font fontWithSize:[self screenSize]];
    }
    return self;
}

@end

@implementation UITextField (FontSize)

+ (void)load {
    if(!UITextFieldEnable) return;
    
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }

        self.font = [self.font fontWithSize:[self screenSize]];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        //        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
        //        NSArray *ignoreTags = [UIView getIgnoreTags];
        //        for (NSNumber *num in ignoreTags) {
        //            if(self.tag == num.integerValue) return self;
        //        }

        self.font = [self.font fontWithSize:[self screenSize]];
    }
    return self;
}

@end

@implementation UITextView (FontSize)

+ (void)load {
    if(!UITextViewEnable) return;
    
    Method ibImp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myIbImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(ibImp, myIbImp);
    
    //    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    //    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    //    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }
        self.font = [self.font fontWithSize:[self screenSize]];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        //textView 此时的 self.font 还是 nil 所以无法修改
        
        self.font = [self.font fontWithSize:[self screenSize]];
    }
    return self;
}


@end



