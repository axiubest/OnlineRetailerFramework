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
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {

        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        imagePicker.delegate = self;
                        [self presentViewController:imagePicker animated:YES completion:nil];
                        NSLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    NSLog(@"用户第一次同意了访问相册权限");
                } else {
                    NSLog(@"用户第一次拒绝了访问相册");
                }
            }];
            
        } else if (status == PHAuthorizationStatusAuthorized) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 创建对象
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        } else if (status == PHAuthorizationStatusDenied) {
            
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
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];

    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    NSLog(@"扫描结果 － － %@", features);
    
    for (int index = 0; index < [features count]; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        NSString *scannedResult = feature.messageString;
        NSLog(@"result:%@",scannedResult);
        

    }
}
@end
