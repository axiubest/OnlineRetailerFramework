//
//  XIU_CountryCodeViewController.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/7.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^returnCountryCodeBlock) (NSString *countryCodeStr);
@interface XIU_CountryCodeViewController : XIU_HiddenTabBarController

@property (nonatomic, copy) returnCountryCodeBlock returnCountryCodeBlock;

-(void)toReturnCountryCode:(returnCountryCodeBlock)block;

@end
