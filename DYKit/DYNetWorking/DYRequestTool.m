//
//  DYRequestTool.m
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import "DYRequestTool.h"
#import <AFNetworkActivityIndicatorManager.h>

#import "NSString+DYUTF8Encoding.h"
#import "DYImageScaleTools.h"
#import "DYCacheManager.h"
@implementation DYRequestTool
+ (instancetype)defaultTool{
    
    static DYRequestTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DYRequestTool alloc] init];
    });
    return instance;
}

- (instancetype)init{
    
    if (self = [super init]) {
        //无条件地信任服务器端返回的证书。
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        self.securityPolicy = [AFSecurityPolicy defaultPolicy];
        self.securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy.validatesDomainName = NO;
        /*因为与缓存互通 服务器返回的数据 必须是二进制*/
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                                          @"application/json",
                                                          @"text/json",
                                                          @"text/plain",
                                                          @"text/javascript",
                                                          @"text/xml",
                                                          @"image/*",nil];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
    
}

- (void)dealloc{
    [self invalidateSessionCancelingTasks:YES];
}


- (NSURLSessionDataTask *)dataTaskWithMethod:(DYRequestConfig *)config
                                    progress:(void(^)(NSProgress * _Nonnull))progress
                                     success:(void(^)(NSURLSessionDataTask *task , id responseObject))success
                                     failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure{
    
    self.requestSerializer = config.requsetSerializer == DYJSONRequestSerializer ? [AFJSONRequestSerializer serializer]:[AFHTTPRequestSerializer serializer];
    self.requestSerializer.timeoutInterval = config.timeoutInterval?config.timeoutInterval:30;
    if ([[config mutableHTTPRequestHeader] allKeys].count > 0) {
        [[config mutableHTTPRequestHeader] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    NSString *urlString = [NSString dy_stringUTF8Encoding:config.urlString];
    if (config.methodType == DYMethodTypePOST) {
        return [self POST:urlString parameters:config.parameters progress:progress success:success failure:failure];
    }else if (config.methodType == DYMethodTypePUT){
        return [self PUT:urlString parameters:config.parameters success:success failure:failure];
    }else if (config.methodType == DYMethodTypePATCH){
        return [self PATCH:urlString parameters:config.parameters success:success failure:failure];
    }else if (config.methodType == DYMethodTypeDELETE){
        return [self DELETE:urlString parameters:config.parameters success:success failure:failure];
    }else{
        return [self GET:urlString parameters:config.parameters progress:progress success:success failure:failure];
    }
    
    
}


- (NSURLSessionDataTask *)uploadWithRequest:(DYRequestConfig *)config
                                   progress:(void (^)(NSProgress * _Nonnull))progress
                                    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success
                                    failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure{
    NSURLSessionDataTask *uploadTask = [self POST:[NSString dy_stringUTF8Encoding:config.urlString] parameters:config.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [config.uploadDatas enumerateObjectsUsingBlock:^(DYUploadData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.fileData) {
                if (obj.fileName && obj.mimeType) {
                    [formData appendPartWithFileData:obj.fileData name:obj.name fileName:obj.fileName mimeType:obj.mimeType];
                }else{
                    [formData appendPartWithFormData:obj.fileData name:obj.name];
                }
            }else if (obj.fileURL){
                if (obj.fileName && obj.mimeType) {
                    [formData appendPartWithFileURL:obj.fileURL name:obj.name fileName:obj.fileName mimeType:obj.mimeType error:nil];
                }
            }
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress?progress(uploadProgress):nil;
        });
    } success:success failure:failure];
    
    return uploadTask;
}






/**
 上传图片，内部处理了图片压缩
 
 @param config DYRequestConfig
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return task
 */
- (NSURLSessionDataTask *)uploadImgWithRequest:(DYRequestConfig *)config
                                      progress:(void(^)(NSProgress * _Nonnull))progress
                                       success:(void(^)(NSURLSessionDataTask *task , id responseObject))success
                                       failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure{
    NSURLSessionDataTask *uploadTask = [self POST:[NSString dy_stringUTF8Encoding:config.urlString] parameters:config.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [config.uploadDatas enumerateObjectsUsingBlock:^(DYUploadData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.uploadImage) {
                if (obj.fileName && obj.mimeType) {
                    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                        if (config.compressType == DYUploadCompressEqualProportion) {
                            obj.fileData = [DYImageScaleTools reduceOfImageWithEqualProportion:obj.uploadImage maxByte:50];
                            
                        }else if (config.compressType == DYUploadCompressTwoPoints){
                            obj.fileData = [DYImageScaleTools reduceOfImageWithTwoPoint:obj.uploadImage maxByte:50];
                            
                        }else{
                             obj.fileData = [DYImageScaleTools reduceOfImageWithWeiChate:obj.uploadImage maxByte:50];
                        }

                        [formData appendPartWithFileData:obj.fileData name:obj.name fileName:obj.fileName mimeType:obj.mimeType];
                    });
                  
                }else{
                    //[formData appendPartWithFormData:obj.fileData name:obj.name];
                }
            }else if (obj.fileURL){
                if (obj.fileName && obj.mimeType) {
                    [formData appendPartWithFileURL:obj.fileURL name:obj.name fileName:obj.fileName mimeType:obj.mimeType error:nil];
                }
            }
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress?progress(uploadProgress):nil;
        });
    } success:success failure:failure];
    
    return uploadTask;
}


- (NSURLSessionDownloadTask *)downloadWithRequest:(DYRequestConfig *)config
                             downloadProgress:(void (^)(NSProgress * progress))downloadProgressBlock completionHandler:(void (^)(NSURLResponse * _Nonnull, NSURL * _Nonnull, NSError * _Nonnull))completionHandler{
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString dy_stringUTF8Encoding:config.urlString]]];
    
    self.requestSerializer.timeoutInterval = config.timeoutInterval?config.timeoutInterval:30;
    if ([[config mutableHTTPRequestHeader] allKeys].count > 0) {
        [[config mutableHTTPRequestHeader] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    NSURL *downloadFileSavePath;
    config.downloadSavePath = config.downloadSavePath ? config.downloadSavePath : [DYCacheManager shareInstance].tmpPath;
    BOOL isDircetory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:config.downloadSavePath isDirectory:&isDircetory]) {
        isDircetory = NO;
    }
    if (isDircetory) {
        NSString *fileName = [urlRequest.URL lastPathComponent];
        downloadFileSavePath = [NSURL fileURLWithPath:[NSString pathWithComponents:@[config.downloadSavePath,fileName]] isDirectory:NO];
    }else{
        downloadFileSavePath  = [NSURL fileURLWithPath:config.downloadSavePath isDirectory:NO];
    }
    
 
    NSURLSessionDownloadTask *dataTask = [self downloadTaskWithRequest:urlRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            downloadProgressBlock ? downloadProgressBlock(downloadProgress) : nil;
        });
    
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return downloadFileSavePath;
    } completionHandler:completionHandler];
    [dataTask resume];
    return dataTask;
}
- (void)cancelRequest:(NSString *)urlString completion:(cancelBlock)completion{
    __block NSString *currentUrlString = nil;
    BOOL results;
    @synchronized (self.tasks) {
        [self.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[[obj.currentRequest URL] absoluteString] isEqualToString:[NSString dy_stringUTF8Encoding:urlString]]) {
                currentUrlString = [[obj.currentRequest URL] absoluteString];
                [obj cancel];
                *stop = YES;
            }
        }];
    }
    if (currentUrlString == nil) {
        results = NO;
    }else{
        results = YES;
    }
    completion ? completion(results,currentUrlString) : nil;
}
@end
