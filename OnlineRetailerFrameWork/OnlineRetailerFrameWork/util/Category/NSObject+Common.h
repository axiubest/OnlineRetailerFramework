//
//  NSObject+Common.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (Common)


#pragma mark BaseURL
+ (NSString *)baseURLStr;


#pragma mark NetError

-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;


+ (void)showHudTipStr:(NSString *)tipStr;
@end
