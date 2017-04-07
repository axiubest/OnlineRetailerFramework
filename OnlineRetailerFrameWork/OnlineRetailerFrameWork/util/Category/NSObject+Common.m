//
//  NSObject+Common.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "NSObject+Common.h"
#import "NSObject+Cache.h"
#import "MBProgressHUD.h"


@implementation NSObject (Common)

+ (NSString *)baseURLStr{
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:KBASEURL] ?: KBASEURL;
}






//返回错误代码
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError {
    NSError *error = nil;
    //code为非0值时，表示有错
    NSInteger errorCode = [(NSNumber *)[responseJSON valueForKeyPath:@"code"] integerValue];
    
    if (errorCode != 0) {
        error = [NSError errorWithDomain:[NSObject baseURLStr] code:errorCode userInfo:responseJSON];
        if (errorCode == 1) {//wrong password
            [NSObject showHudTipStr:responseJSON[@"msg"]];
        }
        if (errorCode == 1000 || errorCode == 3207) {//用户未登录
            if ([XIU_Login isLogin]) {
                [XIU_Login doLogOut];//已登录的状态要抹掉
                //更新 UI 要延迟 >1.0 秒，否则屏幕可能会不响应触摸事件。。暂不知为何
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //                    [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
                    //                    kTipAlert(@"%@", [NSObject tipFromError:error]);
                });
            }
        }
    }
    return error;
}



+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }
}

@end
