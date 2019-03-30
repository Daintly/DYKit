//
//  DYCacheManager.h
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/28.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import <Foundation/Foundation.h>

/**缓存是否存储成功的block*/
typedef void(^DYCacheIsSuccessBlock)(BOOL isSuccess);
/**得到缓存的block*/
typedef void(^DYCacheBlock)(NSData *data , NSString *filePath);

/**缓存完成的后续操作block*/
typedef void(^DYCacheCompletedBlock)(void);

@interface DYCacheManager : NSObject

+ (DYCacheManager *)shareInstance;

/**
 获取沙盒tmp的文件目录
 
 @return tmp路径
 */
- (NSString *)tmpPath;

/**
 判断沙盒是否对应的值
 
 @param key             url
 
 @return YES/NO
 */
- (BOOL)diskCacheExistsWithKey:(NSString *)key;
/**
 判断沙盒是否对应的值
 
 @param key             url
 @param path            沙盒路径
 @return YES/NO
 */
- (BOOL)diskCacheExistsWithKey:(NSString *)key path:(NSString *)path;

/**
 *  返回数据及路径
 *  @param  key         存储的文件的url
 *  @param  value       返回在本地的数据及存储文件路径
 */
- (void)getCacheDataForKey:(NSString *)key value:(DYCacheBlock)value;

/**
 把内容,存储到文件
 
 @param content         数据
 @param key             url
 @param isSuccess       是否存储成功
 */
- (void)storeContent:(NSObject *)content forKey:(NSString *)key isSuccess:(DYCacheIsSuccessBlock)isSuccess;
- (void)clearDiskWithpath:(NSString *)path completion:(DYCacheCompletedBlock)completion;
@end

