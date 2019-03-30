//
//  DYRequestConfig.m
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import "DYRequestConfig.h"
#import "DYCacheManager.h"
@implementation DYRequestConfig

- (void)setValue:(NSString *)value forHeaderKey:(NSString *)key{
    if (value) {
        [self.mutableHTTPRequestHeader setValue:value forKey:key];
    }else {
        [self removeHeaderForkey:key];
    }
}

//- (void)setDownloadSavePath:(NSString *)downloadSavePath{
//    downloadSavePath = downloadSavePath;
//}

- (void)setDownloadSavePath:(NSString *)downloadSavePath{
    _downloadSavePath = downloadSavePath;
}

- (void)removeHeaderForkey:(NSString *)key{
    if (!key) return;
    [self.mutableHTTPRequestHeader removeObjectForKey:key];

}

- (NSMutableDictionary *)mutableHTTPRequestHeader{
    if (!_mutableHTTPRequestHeader) {
        _mutableHTTPRequestHeader = [[NSMutableDictionary alloc] init];
    }
    return _mutableHTTPRequestHeader;
}
- (NSMutableArray<DYUploadData *> *)uploadDatas{
    if (!_uploadDatas) {
        _uploadDatas = [NSMutableArray <DYUploadData *> new];
    }return _uploadDatas;
}


#pragma mark - 上传请求参数
- (void)addFormDataWithName:(NSString *)name fileData:(NSData *)fileData {
    DYUploadData *formData = [DYUploadData formDataWithName:name fileData:fileData];
    [self.uploadDatas addObject:formData];
}

- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData {
    DYUploadData *formData = [DYUploadData formDataWithName:name fileName:fileName mimeType:mimeType fileData:fileData];
    [self.uploadDatas addObject:formData];
}

- (void)addFormDataWithName:(NSString *)name fileURL:(NSURL *)fileURL {
    DYUploadData *formData = [DYUploadData formDataWithName:name fileURL:fileURL];
    [self.uploadDatas addObject:formData];
}

- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL {
    DYUploadData *formData = [DYUploadData formDataWithName:name fileName:fileName mimeType:mimeType fileURL:fileURL];
    [self.uploadDatas addObject:formData];
}


@end
@implementation DYUploadData

+ (instancetype)formDataWithName:(NSString *)name fileURL:(NSURL *)fileURL{
    DYUploadData *formData = [DYUploadData new];
    formData.name = name;
    formData.fileURL = fileURL;
    return formData;
}

+ (instancetype)formDataWithName:(NSString *)name fileData:(NSData *)fileData{
    DYUploadData *formData = [DYUploadData new];
    formData.name = name;
    formData.fileData = fileData;
    return formData;
}


+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData{
    DYUploadData *formData = [DYUploadData new];
    formData.name = name;
    formData.fileName = fileName;
    formData.mimeType = mimeType;
    formData.fileData = fileData;
    return formData;
}


+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL{
    
    DYUploadData *formData = [DYUploadData new];
    formData.name = name;
    formData.fileName = fileName;
    formData.mimeType = mimeType;
    formData.fileURL = fileURL;
    return formData;
    
}
@end
