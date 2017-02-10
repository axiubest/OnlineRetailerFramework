//
//  UIView+RunTime_FontSize.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/9.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

//RunTime全局修改字体
#import <UIKit/UIKit.h>


#define UITextViewEnable 1
#define UITextFieldEnable 1
#define UIButtonEnable 1
#define UILabelEnable 1

@interface UIView (RunTime_FontSize)

//忽略字体设置
+ (void)setIgnoreTags:(NSArray<NSNumber*> *)tagArr;

@end
