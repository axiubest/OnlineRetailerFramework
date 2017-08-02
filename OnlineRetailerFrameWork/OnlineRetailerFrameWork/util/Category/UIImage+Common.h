//
//  UIImage+Common.h
//  OnlineRetailerFrameWork
//
//  Created by Apple on 2017/8/2.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)


/*
 * image 转 data post 上传图片流
 */
+ (NSString *)imageBase64WithDataURL:(UIImage *)image;
@end
