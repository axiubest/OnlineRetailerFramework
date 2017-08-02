//
//  UIImage+Common.m
//  OnlineRetailerFrameWork
//
//  Created by Apple on 2017/8/2.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)
+ (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =50 / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}
@end
