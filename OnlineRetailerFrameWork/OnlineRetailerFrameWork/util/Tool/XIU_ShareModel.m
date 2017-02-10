//
//  XIU_ShareModel.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/24.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ShareModel.h"

@implementation XIU_ShareModel




-(void)setUrl:(NSString *)url {
    if (!url) {
        _url = @"input your nutification if the value is NULL";
    }
    url = _url;
}

-(void)setDiscription:(NSString *)discription {
    if (!discription) {
        _discription = @"input  your information if the value is NULL";
    }
    discription = _discription;
}
@end
