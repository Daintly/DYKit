//
//  DYRequestManager.m
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import "DYRequestManager.h"

#import "NSString+DYUTF8Encoding.h"
#import "DYRequestTool.h"
#import "DYCacheManager.h"
@implementation DYRequestManager


+ (void)requestWithConfig:(requestConfig)config success:(requestSuccess)success failure:(requestFailure)failure{
    [self requestWithConfig:config progress:nil success:success failure:failure];
}


+ (void)requestWithConfig:(requestConfig)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure {
    DYRequestConfig *request=[[DYRequestConfig alloc]init];
    config ? config(request) : nil;
    [self sendRequest:request progress:progress success:success failure:failure];
}


+ (void)requestUploadImageWithConfig:(requestConfig)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure {
    DYRequestConfig *request=[[DYRequestConfig alloc]init];
    config ? config(request) : nil;
      if ([request.urlString isEqualToString:@""]||request.urlString == nil) return;
    [self sendUploadImageRequest:request progress:progress success:success failure:failure];
}



+(void)sendRequest:(DYRequestConfig *)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure{
    if ([config.urlString isEqualToString:@""]||config.urlString == nil) return;
    if (config.methodType == DYMethodTypeUpload) {
        [self sendUploadRequest:config progress:progress success:success failure:failure];
    }else if (config.methodType == DYMethodTypeDownLoad){
        [self sendDownLoadRequest:config progress:progress success:success failure:failure];
    }else if (config.methodType == DYMethodTypeUploadImage){
         [self sendUploadImageRequest:config progress:progress success:success failure:failure];
    }
    else{
        [self sendHTTPRequest:config progress:progress success:success failure:failure];
    }
    
}

+ (void)sendUploadRequest:(DYRequestConfig *)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure{
    [[DYRequestTool defaultTool] uploadWithRequest:config progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject,0,NO):nil;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
    
}

+ (void)sendUploadImageRequest:(DYRequestConfig *)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure{
    [[DYRequestTool defaultTool] uploadImgWithRequest:config progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject,0,NO):nil;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
    
}



+ (void)sendDownLoadRequest:(DYRequestConfig *)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure{
    [[DYRequestTool defaultTool] downloadWithRequest:config downloadProgress:progress completionHandler:^(NSURLResponse * response, NSURL * filePath, NSError * error) {
        failure ? failure(error) : nil;
        success ? success([filePath path],config.requestType,NO) : nil;
    }];
    
}

+ (void)sendHTTPRequest:(DYRequestConfig *)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure{
    NSString *key = [self keyWithParameters:config];
    if ([[DYCacheManager shareInstance] diskCacheExistsWithKey:key] && config.requestType != DYReuestTypeRefresh && config.requestType != DYReuestTypeRefreshMore) {
        [[DYCacheManager shareInstance] getCacheDataForKey:key value:^(NSData *data, NSString *filePath) {
            id result = [self responseSerializerConfig:config responseObject:data];
            success ? success(result,config.requestType,YES) : nil;
        }];
    }else{
        [self dataTaskWithHTTPRequest:config progress:progress success:success failure:failure];
    }
    
    
}
#pragma mark 发起HTTP请求
+ (void)dataTaskWithHTTPRequest:(DYRequestConfig *)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure{
    [[DYRequestTool defaultTool] dataTaskWithMethod:config progress:^(NSProgress * _Nonnull dy_progress) {
        progress ? progress(dy_progress) : nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self storeObject:responseObject request:config];
        id result = [self responseSerializerConfig:config responseObject:responseObject];
        success ? success(result,config.requestType,NO) : nil ;
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}


+ (void)storeObject:(NSObject *)object request:(DYRequestConfig *)config{
    NSString * key= [self keyWithParameters:config];
    [[DYCacheManager shareInstance] storeContent:object forKey:key isSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"store successful");
        }else{
            NSLog(@"store failure");
        }
    }];
}



/**
 数据转换

 @param config
 @param responseObject
 @return 返回二进制数据
 */
+(id)responseSerializerConfig:(DYRequestConfig *)config responseObject:(id)responseObject{
    if (config.responseSerializer == DYHTTPResponseSerializer) {
        return responseObject;
    }else{
        NSError *serializationError = nil;
        NSData *data = (NSData *)responseObject;

        BOOL isSpace = [data isEqualToData:[NSData dataWithBytes:" " length:1]];
        if (data.length > 0 && !isSpace) {
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
            return result;
        }else{
            return nil;
        }
    }
    
    
}

+(NSString *)keyWithParameters:(DYRequestConfig *)config{
    if (config.parametersfiltrationCacheKey.count>0) {
        NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:config.parameters];
        [mutableParameters removeObjectForKey:config.parametersfiltrationCacheKey];
        config.parameters = [mutableParameters copy];
    }
    NSString *urlStringCacheKey;
    if (config.customCacheKey) {
        urlStringCacheKey = config.customCacheKey;
    }else{
        urlStringCacheKey = config.urlString;
    }
    return [NSString dy_stringUTF8Encoding:[NSString dy_urlString:urlStringCacheKey appendingParameters:config.parameters]];
}
@end
