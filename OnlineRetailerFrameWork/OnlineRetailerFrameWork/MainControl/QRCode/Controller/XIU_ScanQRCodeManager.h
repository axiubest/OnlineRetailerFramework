//
//  XIU_ScanQRCodeManager.h
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/21.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>
@interface XIU_ScanQRCodeManager : NSObject
/** 扫描二维码 */
+ (void)XIU_scanningQRCodeOutsideVC:(UIViewController *)outsideVC session:(AVCaptureSession *)session previewLayer:(AVCaptureVideoPreviewLayer *)previewLayer;

@end
