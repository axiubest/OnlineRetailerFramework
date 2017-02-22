//
//  XIU_UMManager.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/21.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_UMManager.h"
#import <UMSocialCore/UMSocialCore.h>


#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#import <UMMobClick/MobClick.h>
@implementation XIU_UMManager

/*
 * 
 @"copylink": @"复制链接",
 @"sina": @"新浪微博",
 @"qzone": @"QQ空间",
 @"qq": @"QQ好友",
 @"wxtimeline": @"朋友圈",
 @"wxsession": @"微信好友",
 @"inform": @"举报"

 */

// chicked share button with snsName
+ (void)shareObjectWithSnsName:(NSString *)snsName WithMessageValue:(XIU_ShareModel *)model {

    
    if ([snsName isEqualToString:@"copylink"]) {
        [[UIPasteboard generalPasteboard] setString:@"连接地址"];
        [NSObject showHudTipStr:@"链接已拷贝到粘贴板"];
    }if ([snsName isEqualToString:@"sina"]) {
        [[self class] shareWebPageToPlatformType:UMSocialPlatformType_Sina WithModel:model];
    }if ([snsName isEqualToString:@"qq"]) {
        [[self class] shareWebPageToPlatformType:UMSocialPlatformType_QQ WithModel:model];
    }if ([snsName isEqualToString:@"qzone"]) {
         [[self class] shareWebPageToPlatformType:UMSocialPlatformType_Qzone WithModel:model];
    }if ([snsName isEqualToString:@"wxtimeline"]) {
         [[self class] shareWebPageToPlatformType:UMSocialPlatformType_WechatSession WithModel:model];
    }if ([snsName isEqualToString:@"wxtimeline"]) {
         [[self class] shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine WithModel:model];
    }

}

+ (NSMutableArray *)removeObjOfUninstallProduct:(NSMutableArray *)resultSnsValues {
    if (![WXApi isWXAppInstalled]) {
        [resultSnsValues removeObjectsInArray:@[
                                                @"wxsession",
                                                @"wxtimeline",
                                                ]];
        
        
    }if (![QQApiInterface isQQInstalled]) {
        [resultSnsValues removeObjectsInArray:@[
                                                @"qq",
                                                @"qzone",
                                                ]];
        
    }if (![WeiboSDK isWeiboAppInstalled]) {
        [resultSnsValues removeObjectsInArray:@[@"sina"]];
        
    }
    return resultSnsValues;
}




+(void)UmengShareFunc {
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_APPKEY];
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:XIU_Social_WX_ID appSecret:XIU_Social_WX_Secret redirectURL:XIU_Social_RedirectURL];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:XIU_Social_QQ_ID/*设置QQ平台的appID*/  appSecret:XIU_Social_QQ_Secret redirectURL:XIU_Social_RedirectURL];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:XIU_Social_Sina_ID  appSecret:XIU_Social_Sina_Select redirectURL:XIU_Social_RedirectURL];

}

//回调
+ (BOOL)UMengShareWithBlockOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}



- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType WithModel:(XIU_ShareModel *)model {
    {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.title descr:model.discription thumImage:[UIImage imageNamed:@"icon"]];
        //设置网页地址
        shareObject.webpageUrl = model.url;;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = model;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
    }
}




#pragma mark UmengMobClickFunc
+ (void)UmengMobClickFunc {
//    UMConfigInstance.appKey = USHARE_APPKEY;
//    UMConfigInstance.channelId = @"App Store";
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}
@end
