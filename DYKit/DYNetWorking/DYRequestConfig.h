//
//  DYRequestConfig.h
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYRequestConst.h"
#import <UIKit/UIKit.h>
@class DYUploadData;
NS_ASSUME_NONNULL_BEGIN

@interface DYRequestConfig : NSObject

/**
 缓存方式
 */
@property (nonatomic, assign) RequestType  requestType;

/**
  图片压缩策略
 */
@property (nonatomic, assign) DYUploadCompressType compressType;

/**
 请求方式
 */
@property (nonatomic, assign) MethodType methodType;

/**
 请求参数的格式.默认是HTTP
 */
@property (nonatomic, assign) RequestSerializerType  requsetSerializer;

/**
 返回响应数据的格式.默认是JSON
 */
@property (nonatomic, assign) ResponseSerializerType responseSerializer;


/**
 接口请求地址
 */
@property (nonatomic, copy,nonnull) NSString *  urlString;


/**
 提供外部参数配置
 */
@property (nullable,nonatomic, strong) id parameters;

/**
 自定义缓存key，在urlString不作为缓存key时使用
 */
@property (nonatomic, copy) NSString *customCacheKey;

/**
 过滤parameters 里的随机参数
 */
@property (nonatomic,strong) NSArray *parametersfiltrationCacheKey;

/**
 设置超时时间，默认为30s
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;


/**
 请求头对象
 */
@property (nonatomic, strong,nonnull) NSMutableDictionary * mutableHTTPRequestHeader;

/**
 为上传请求提供数据
 */
@property (nonatomic, strong,nullable) NSMutableArray<DYUploadData *> *uploadDatas;

/**
 *  存储路径 只有下载文件方法有用 默认是 NSTemporaryDirectory();
 */
@property (nonatomic, copy) NSString *downloadSavePath;

/**
 添加请求头

 @param value value
 @param key   key
 */
- (void)setValue:(NSString * _Nonnull)value forHeaderKey:(NSString *)key;

- (void)removeHeaderForkey:(NSString * _Nonnull)key;



//============================================================
- (void)addFormDataWithName:(NSString *_Nonnull)name fileData:(NSData *_Nonnull)fileData;
- (void)addFormDataWithName:(NSString *_Nonnull)name fileName:(NSString *_Nonnull)fileName mimeType:(NSString *_Nonnull)mimeType fileData:(NSData *_Nonnull)fileData;
- (void)addFormDataWithName:(NSString *_Nonnull)name fileURL:(NSURL *_Nonnull)fileURL;
- (void)addFormDataWithName:(NSString *_Nonnull)name fileName:(NSString *_Nonnull)fileName mimeType:(NSString *_Nonnull)mimeType fileURL:(NSURL *_Nonnull)fileURL;
@end


@interface DYUploadData : NSObject


/**
 文件对应服务器上的字段
 */
@property (nonatomic, copy) NSString * _Nonnull name;
/**
 文件名
 */
@property (nonatomic, copy,nullable) NSString *fileName;

/**
 png。jpeg
 */
@property (nonatomic, copy,nullable) NSString *mimeType;

/**
 传入的若是图片，内部做图片压缩处理
 */
@property (nonatomic, strong,nullable) UIImage *uploadImage;
@property (nonatomic, strong,nullable) NSData *fileData;
@property (nonatomic, strong,nullable) NSURL *fileURL;

//注意:“fileData”和“fileURL”中的任何一个都不应该是“nil”，“fileName”和“mimeType”都必须是“nil”，或者同时被分配，



+ (instancetype _Nonnull )formDataWithName:(NSString *_Nonnull)name fileData:(NSData *_Nonnull)fileData;
+ (instancetype _Nonnull )formDataWithName:(NSString *_Nonnull)name fileName:(NSString *_Nonnull)fileName mimeType:(NSString *_Nonnull)mimeType fileData:(NSData *_Nonnull)fileData;
+ (instancetype _Nonnull )formDataWithName:(NSString *_Nonnull)name fileURL:(NSURL *_Nonnull)fileURL;
+ (instancetype _Nonnull )formDataWithName:(NSString *_Nonnull)name fileName:(NSString *_Nonnull)fileName mimeType:(NSString *_Nonnull)mimeType fileURL:(NSURL *_Nonnull)fileURL;

@end
NS_ASSUME_NONNULL_END
