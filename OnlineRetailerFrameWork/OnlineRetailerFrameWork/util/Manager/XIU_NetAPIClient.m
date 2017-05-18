//
//  XIU_NetAPIClient.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_NetAPIClient.h"
#import "NSObject+Cache.h"
@implementation XIU_NetAPIClient

static XIU_NetAPIClient *_sharedClient = nil;
static dispatch_once_t onceToken;

+ (XIU_NetAPIClient *)sharedJsonClient {
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[XIU_NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject baseURLStr]]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}


- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}



- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    switch (method) {
        case Get: {
            //所有 Get 请求，增加缓存机制
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:aPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                  id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    responseObject = [NSObject loadResponseWithPath:localPath];
                    block(responseObject, error);
                }else {
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        //判断数据是否符合预期，给出提示
                        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                            if (responseObject[@"data"][@"too_many_files"]) {
                                if (autoShowError) {
//                                    [NSObject showHudTipStr:@"文件太多，不能正常显示"];
                                }
                            }
                        }
                        [NSObject saveResponseData:responseObject toPath:localPath];
                    }
                    block(responseObject, nil);

                }
               

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                
            }];
        }
            break;
        case Post: {
            
            
        }
            break;
   
        default:
            break;
    }
    
}




//文件下载
+ (void)requestJSPatchDownLoadFileWithPath:(NSString *)aPath
                         withParams:(NSDictionary*)params
                     withMethodType:(NetworkMethod)method
                           andBlock:(void (^)(id data, NSError *error))block {
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:aPath]];
    
    //下载Task操作
    [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        
        // 给Progress添加监听 KVO
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置进度条的百分比
            
//            self.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
//        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
//        UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
        
        
    }];
}
@end
