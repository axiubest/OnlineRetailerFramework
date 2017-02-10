//
//  NSObject+Cache.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Encryption.h"

@interface NSObject (Cache)

+ (NSString* )pathInCacheDirectory:(NSString *)fileName;

+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;
+ (id)loadResponseWithPath:(NSString *)requestPath;//返回一个NSDictionary类型的json数据


@end
