//
//  XIU_PayManager.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_PayManager.h"
#import "WXApi.h"

@interface XIU_PayManager ()<WXApiDelegate>


@end

@implementation XIU_PayManager

+(void)pay {
    [WXApi registerApp:@"wx93564c20b5db911f"];
}

+(void)payMessage {
    PayReq *request = [[PayReq alloc] init];
    /** 商家向财付通申请的商家id */
    request.partnerId = @"1395169402";
    /** 预支付订单 */
    request.prepayId= @"82010380001603250865be9c4c063c30";
    /** 商家根据财付通文档填写的数据和签名 */
    request.package = @"Sign=WXPay";
    /** 随机串，防重发 */
    request.nonceStr= @"lUu5qloVJV7rrJlr";
    /** 时间戳，防重发 */
    request.timeStamp= 1458893985;
    /** 商家根据微信开放平台文档对数据做的签名 */
    request.sign= @"LIM2017LIM2017LIM2017LIM2017LIM2";

    [WXApi sendReq: request];
   
}
@end
