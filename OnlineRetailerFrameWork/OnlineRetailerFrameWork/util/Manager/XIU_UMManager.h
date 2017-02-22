//
//  XIU_UMManager.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/21.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>
#import "XIU_ShareModel.h"
@interface XIU_UMManager : UMSocialHandler

+(void)UmengMobClickFunc;

+(void)UmengShareFunc;

+ (void)shareObjectWithSnsName:(NSString *)snsName WithMessageValue:(XIU_ShareModel *)model;

+ (BOOL)UMengShareWithBlockOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

+ (NSMutableArray *)removeObjOfUninstallProduct:(NSMutableArray *)resultSnsValues;
@end
