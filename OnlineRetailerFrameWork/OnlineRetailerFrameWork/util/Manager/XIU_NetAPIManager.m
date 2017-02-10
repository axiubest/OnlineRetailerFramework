//
//  XIU_NetAPIManager.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/13.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_NetAPIManager.h"
#import "XIU_NetAPIClient.h"
#import "MJExtension.h"


@implementation XIU_NetAPIManager

+ (instancetype)sharedManager {
    static XIU_NetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}



- (void)request_Login_WithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id data, NSError *error))block {
    
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        id requestData = [[data valueForKeyPath:@"user"] lastObject];
        
        if (requestData) {
            [XIU_Login doLogin:requestData];
            XIU_User *user = [XIU_User mj_objectWithKeyValues:requestData];

            block(user, nil);

        }else {
            block(nil,error);
        }

    }];
}
@end
