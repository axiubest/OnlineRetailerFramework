//
//  XIU_QRCodeViewController.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/21.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ScanQRCodeViewController.h"
#import "XIU_ScanQRCodeView.h"
#import "XIU_ScanQRCodeManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

static NSString *const NavgationItem_AblumImageName = @"相册";
@interface XIU_ScanQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) XIU_ScanQRCodeView *QRCodeView;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;



@end

@implementation XIU_ScanQRCodeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
           self.QRCodeView = [[XIU_ScanQRCodeView alloc] initWithFrame:self.view.frame WithLayer:self.view.layer];
    [self.view addSubview:self.QRCodeView];
    
    [self setupScanningQRCode];
    
    [self createNavgationButtonWithImageNmae:NavgationItem_AblumImageName title:nil target:self action:@selector(selectPhotoInAlbum) type:UINavigationItem_Type_RightItem];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark QRCode sacn
- (void)setupScanningQRCode {
    
    self.session = [[AVCaptureSession alloc] init];
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    [XIU_ScanQRCodeManager XIU_scanningQRCodeOutsideVC:self session:_session previewLayer:_previewLayer];
}

#pragma mark QRCode-Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    [self playSoundEffect:@"sound.caf"];
    
    [self.session stopRunning];
    
    [self.previewLayer removeFromSuperlayer];
    
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSLog(@"metadataObjects = %@", metadataObjects);
        
        if ([obj.stringValue hasPrefix:@"http"]) {
            
            NSLog(@"stringValue = = %@", obj.stringValue);
    
        } else { // 扫描结果为条形码
            
            NSLog(@"stringValue = = %@", obj.stringValue);

        }
    }
}

#pragma mark - - - 扫描提示声

- (void)playSoundEffect:(NSString *)name{
    
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    SystemSoundID soundID = 0;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    AudioServicesPlaySystemSound(soundID);
}

void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    NSLog(@"播放完成...");
}

#pragma mark - - - 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.QRCodeView removeTimer];
    [self.QRCodeView removeFromSuperview];
    self.QRCodeView = nil;
}






- (void)selectPhotoInAlbum {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 创建对象
                        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
                        imagePicker.delegate = self; // 指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
                        [self presentViewController:imagePicker animated:YES completion:nil]; // 显示相册
                        NSLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    // 用户第一次同意了访问相册权限
                    NSLog(@"用户第一次同意了访问相册权限");
                } else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相册");
                }
            }];
            
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 创建对象
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
            imagePicker.delegate = self; // 指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
            [self presentViewController:imagePicker animated:YES completion:nil]; // 显示相册
            
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            
            NSLog(@"请去-> [设置 - 隐私 - 照片 - SGQRCodeExample] 打开访问开关");
            
        } else if (status == PHAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
        
    } else {
        NSLog(@"未检测到您的摄像头, 请在真机上测试");
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"info - - - %@", info);
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self scanQRCodeFromPhotosInTheAlbum:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    }];
}

- (void)scanQRCodeFromPhotosInTheAlbum:(UIImage *)image {
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    NSLog(@"扫描结果 － － %@", features);
    
    for (int index = 0; index < [features count]; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        NSString *scannedResult = feature.messageString;
        NSLog(@"result:%@",scannedResult);
        
//        if (self.first_push) {
//            ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//            jumpVC.jump_URL = scannedResult;
//            [self.navigationController pushViewController:jumpVC animated:YES];
//            
//            self.first_push = NO;
//        }
    }
}
@end
