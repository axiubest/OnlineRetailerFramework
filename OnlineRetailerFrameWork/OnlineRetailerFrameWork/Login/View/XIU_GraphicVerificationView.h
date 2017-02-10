//
//  XIU_GraphicVerificationView.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/7.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

/*
 *图形验证码工具
 */
#import <UIKit/UIKit.h>

@interface XIU_GraphicVerificationView : UIView

@property (nonatomic, retain) NSMutableString *changeString;  //验证码的字符串

- (void)randomNumber;


@end
