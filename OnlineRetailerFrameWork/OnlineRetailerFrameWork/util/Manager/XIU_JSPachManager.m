//
//  XIU_JSPachManager.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/2/5.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_JSPachManager.h"
#import "JPEngine.h"
#import "XIU_NetAPIClient.h"

@interface XIU_JSPachManager ()
{
    BOOL isPatch;
}

@end

@implementation XIU_JSPachManager

+ (instancetype)contextManager {
    static XIU_JSPachManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager  = [[self alloc] init];
        [JPEngine startEngine];
        [self boolPatch];

    });
    return manager;
}

+ (void)boolPatch {
    //服务器获取补丁判断
    //有补丁下载补丁
    
    [XIU_NetAPIClient requestJSPatchDownLoadFileWithPath:patchUpdateURL withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        
        if (data) {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
            NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
            sourcePath == nil ? @"down load error" : [JPEngine evaluateScript:script];
        }else {
            NSLog(@"patch download error=%@", error);
        }
    }];
    


}
@end
