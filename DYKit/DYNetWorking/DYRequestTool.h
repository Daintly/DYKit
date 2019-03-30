//
//  DYRequestTool.h
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "DYRequestConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface DYRequestTool : AFHTTPSessionManager
+ (instancetype)defaultTool;


/**
 发起请求

 @param config DYRequestConfig
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return task
 */
- (NSURLSessionDataTask *)dataTaskWithMethod:(DYRequestConfig *)config
                                    progress:(void(^)(NSProgress * _Nonnull))progress
                                     success:(void(^)(NSURLSessionDataTask *task , id responseObject))success
                                     failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;

/**
 上传文件

 @param config DYRequestConfig
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return task
 */
- (NSURLSessionDataTask *)uploadWithRequest:(DYRequestConfig *)config
                                    progress:(void(^)(NSProgress * _Nonnull))progress
                                     success:(void(^)(NSURLSessionDataTask *task , id responseObject))success
                                     failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;


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
                                    failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;



/**
 下载文件

 @param config DYRequestConfig
 @param downloadProgressBlock 进度
 @param completionHandler 回调
 @return task
 */
- (NSURLSessionDownloadTask *)downloadWithRequest:(DYRequestConfig *)config
                                 downloadProgress:(void (^)(NSProgress * _Nonnull progress))downloadProgressBlock completionHandler:(void (^)(NSURLResponse * _Nonnull, NSURL * _Nonnull, NSError * _Nonnull))completionHandler;

/**
 取消请求

 @param urlString 请求地址
 @param completion 回调
 */
- (void)cancelRequest:(NSString *)urlString completion:(cancelBlock)completion;
@end

NS_ASSUME_NONNULL_END
