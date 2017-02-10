//
//  XIU_LoginService.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/2/10.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XIU_SignInResponse)(BOOL);

@interface XIU_LoginService : NSObject
@property (nonatomic, strong)XIU_Login *login;


- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(XIU_SignInResponse)completeBlock;
@end
