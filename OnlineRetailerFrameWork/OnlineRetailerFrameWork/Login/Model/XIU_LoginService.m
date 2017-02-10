//
//  XIU_LoginService.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/2/10.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_LoginService.h"

@implementation XIU_LoginService
-(XIU_Login *)login {
    if (!_login) {
        _login = [[XIU_Login alloc] init];
    }
    return _login;
}


- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(XIU_SignInResponse)completeBlock {
    
    self.login.phone = username;
    self.login.password = password;
    
    //判断密码正确性
    [[XIU_NetAPIManager sharedManager] request_Login_WithPath:[self.login toPath] Params:[self.login params] andBlock:^(id data, NSError *error) {
        if (data) {
            //在此再进行密码判断
            //            BOOL success = [username isEqualToString:@"user"] && [password isEqualToString:@"password"];
            BOOL success = YES;
            completeBlock(success);
        }
    }];

}

@end
