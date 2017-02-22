//
//  XIU_ScanQRCodeManager.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/21.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ScanQRCodeManager.h"

@implementation XIU_ScanQRCodeManager
/**
 *  扫描二维码
 *
 *  @param outsideVC    外界控制器
 *  @param session    AVCaptureSession 对象
 *  @param previewLayer    AVCaptureVideoPreviewLayer
 */
+ (void)XIU_scanningQRCodeOutsideVC:(UIViewController *)outsideVC session:(AVCaptureSession *)session previewLayer:(AVCaptureVideoPreviewLayer *)previewLayer {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:(id)outsideVC queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、初始化链接对象（会话对象）
    // 高质量采集率
    //session.sessionPreset = AVCaptureSessionPreset1920x1080; // 如果二维码图片过小、或者模糊请使用这句代码，注释下面那句代码
    session.sessionPreset = AVCaptureSessionPresetHigh;
    
    // 5.1 添加会话输入
    [session addInput:input];
    
    // 5.2 添加会话输出
    [session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = outsideVC.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [outsideVC.view.layer insertSublayer:previewLayer atIndex:0];
    
    // 9、启动会话
    [session startRunning];
}


@end
