//
//  UITableViewCell+Common.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/25.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "UITableViewCell+Common.h"

@implementation UITableViewCell (Common)


-(void)alertViewWithString:(NSString *)alertString {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.labelText = alertString;
    hud.mode = MBProgressHUDModeCustomView;
    [hud hide:YES afterDelay:HUDProgress_Time];
}

@end
