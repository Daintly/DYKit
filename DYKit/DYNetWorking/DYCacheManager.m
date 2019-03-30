
//
//  DYCacheManager.m
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/28.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import "DYCacheManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
NSString *const PathSpace =@"DYKit";
NSString *const defaultCachePath =@"AppCache";
static const NSInteger defaultCacheMaxAge = 60 * 60 * 24 * 7;

@interface DYCacheManager ()
/** 磁盘缓存路径*/

@property (nonatomic ,copy)NSString *diskCachePath;
@property (nonatomic, strong) dispatch_queue_t patchQueue;

@end
@implementation DYCacheManager

+ (DYCacheManager *)shareInstance{
    static dispatch_once_t onceToken;
    
    static DYCacheManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init{
    if (self = [super init]) {
        //创建一个串行队列
        _patchQueue = dispatch_queue_create("com.dispatch.DYCacheManager", DISPATCH_QUEUE_SERIAL);
        [self initCachesfileWithName:defaultCachePath];
        /**前台清除*/
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteOldFiles) name:UIApplicationWillTerminateNotification object:nil];
        /**h后台清除缓存*/
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundDeleteOldFiles) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        
    }return self;
}


#pragma mark - 创建存储文件夹
- (void)initCachesfileWithName:(NSString *)name{
    self.diskCachePath = [[self DYKitPath] stringByAppendingPathComponent:name];
    [self createDirectoryAtPath:self.diskCachePath];
}



- (void)createDirectoryAtPath:(NSString *)path{
    if (![[NSFileManager defaultManager]fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }else{
        
    }
}

- (void)deleteOldFiles{
    [self clearCacheWithTime:60 * 60 * 24 * 7 completion:nil];
}


- (void)clearCacheWithTime:(NSTimeInterval)time completion:(DYCacheCompletedBlock)completion{
    [self clearCacheWithTime:time path:self.diskCachePath completion:nil];
}

- (void)clearCacheWithTime:(NSTimeInterval)time path:(NSString *)path completion:(DYCacheCompletedBlock)completion{
    
    if (!time|| !path) return;
    dispatch_async(self.patchQueue, ^{
        NSDate *finalDate = [NSDate dateWithTimeIntervalSinceNow:-time];
        NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [path stringByAppendingPathComponent:fileName];
            NSDictionary *info = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            NSDate *current = [info objectForKey:NSFileModificationDate];
            if ([[current laterDate:finalDate] isEqualToDate:finalDate]) {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
        
    
    
}

- (void)backgroundDeleteOldFiles{
    [self backgroundDeleteOldFilesWith:self.diskCachePath];
}
- (void)backgroundDeleteOldFilesWith:(NSString *)path {
    Class UIApplicationClass = NSClassFromString(@"UIApplication");
    if(!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
        return;
    }
    UIApplication *application = [UIApplication performSelector:@selector(sharedApplication)];
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task and return immediately.
    
    
    [self clearCacheWithTime:defaultCacheMaxAge path:path completion:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];

}


#pragma mark - 清除单个缓存文件
- (void)clearCacheForkey:(NSString *)key{
    [self clearCacheForkey:key completion:nil];
}


- (void)clearCacheForkey:(NSString *)key completion:(DYCacheCompletedBlock)completion{
    
    [self clearCacheForkey:key path:self.diskCachePath completion:completion];
    
}


- (void)clearCacheForkey:(NSString *)key path:(NSString *)path completion:(DYCacheCompletedBlock)completion{
    
    if (!key||!path) return;
    dispatch_async(self.patchQueue, ^{
        NSString *filePath = [[self getDiskCacheWithCodingForKey:key path:path] stringByDeletingPathExtension];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
        
    
    
}

#pragma mark MD5编码
- (NSString *)getDiskCacheWithCodingForKey:(NSString *)key{
   NSString *path  = [self getDiskCacheWithCodingForKey:key path:self.diskCachePath];
    return path;
}
- (NSString *)getDiskCacheWithCodingForKey:(NSString *)key path:(NSString *)path{
    NSString *filename = [self MD5StringForKey:key];
    return [path stringByAppendingPathComponent:filename];
}

- (NSString *)MD5StringForKey:(NSString *)key{
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str,(CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%@",r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9],r[10],r[11],r[12],r[13],r[14],r[15],[[key pathExtension] isEqualToString:@""] ? @"": [NSString stringWithFormat:@".%@",[key pathExtension]]];
    return filename;
}
#pragma mark - 获取沙盒目录
- (NSString *)homePath{
    
    return NSHomeDirectory();
    
}
- (NSString *)documentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
}
- (NSString *)libraryPath{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)cachesPath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

/**存放临时文件*/
- (NSString *)tmpPath{
    return NSTemporaryDirectory();
}

- (NSString *)DYKitPath{
    return [[self cachesPath] stringByAppendingPathComponent:PathSpace];
}

- (BOOL)diskCacheExistsWithKey:(NSString *)key{
    return [self diskCacheExistsWithKey:key path:self.diskCachePath];
}

- (BOOL)diskCacheExistsWithKey:(NSString *)key path:(NSString *)path{
    NSString *isExists = [[self getDiskCacheWithCodingForKey:key path:path] stringByDeletingPathExtension];
    return [[NSFileManager defaultManager] fileExistsAtPath:isExists];
}

#pragma mark - 获取存储数据
- (void)getCacheDataForKey:(NSString *)key value:(DYCacheBlock)value{
    [self getCacheDataForKey:key path:self.diskCachePath value:value];
}



- (void)getCacheDataForKey:(NSString *)key  path:(NSString *)path value:(DYCacheBlock)value{
    if (!key) return;
    dispatch_async(self.patchQueue, ^{
        @autoreleasepool {
            NSString *filePath = [[self getDiskCacheWithCodingForKey:key path:path]stringByDeletingPathExtension];
            NSData *diskData = [NSData dataWithContentsOfFile:filePath];
            if (value) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    value(diskData,filePath);
                });
            }
        }
    });
        
    
}


#pragma mark 存储
- (void)storeContent:(NSObject *)content forKey:(NSString *)key isSuccess:(DYCacheIsSuccessBlock)isSuccess{
    [self storeContent:content forKey:key path:self.diskCachePath isSuccess:isSuccess];
}





- (void)storeContent:(NSObject *)content forKey:(NSString *)key path:(NSString *)path isSuccess:(DYCacheIsSuccessBlock)isSuccess{
    dispatch_async(self.patchQueue,^{
        NSString *codingPath =[[self getDiskCacheWithCodingForKey:key path:path]stringByDeletingPathExtension];
        BOOL result=[self setContent:content writeToFile:codingPath];
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                isSuccess(result);
            });
        }
    });
}


- (BOOL)setContent:(NSObject *)content writeToFile:(NSString *)path{
    if (!content||!path){
        return NO;
    }
    if ([content isKindOfClass:[NSMutableArray class]]) {
        return  [(NSMutableArray *)content writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[NSArray class]]) {
        return [(NSArray *)content writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[NSMutableData class]]) {
        return [(NSMutableData *)content writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[NSData class]]) {
        return  [(NSData *)content writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[NSMutableDictionary class]]) {
        [(NSMutableDictionary *)content writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[NSDictionary class]]) {
        return  [(NSDictionary *)content writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[NSJSONSerialization class]]) {
        return [(NSDictionary *)content writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[NSMutableString class]]) {
        return  [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[NSString class]]) {
        return [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
    }else if ([content isKindOfClass:[UIImage class]]) {
        return [UIImageJPEGRepresentation((UIImage *)content,(CGFloat)0.9) writeToFile:path atomically:YES];
    }else if ([content conformsToProtocol:@protocol(NSCoding)]) {
        return [NSKeyedArchiver archiveRootObject:content toFile:path];
    }else {
        [NSException raise:@"非法的文件内容" format:@"文件类型%@异常。", NSStringFromClass([content class])];
        return NO;
    }
    return NO;
}

#pragma  mark - 清除默认路径缓存
- (void)clearCache{
    [self clearCacheOnCompletion:nil];
}

- (void)clearCacheOnCompletion:(DYCacheCompletedBlock)completion{
    
    dispatch_async(self.patchQueue, ^{
        //[self clearDiskWithpath:self.diskCachePath];
        [[NSFileManager defaultManager] removeItemAtPath:self.diskCachePath error:nil];
        [self createDirectoryAtPath:self.diskCachePath];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(),^{
                completion();
            });
        }
    });
}
#pragma  mark - 清除自定义路径缓存
- (void)clearDiskWithpath:(NSString *)path{
    [self clearDiskWithpath:path completion:nil];
}

- (void)clearDiskWithpath:(NSString *)path completion:(DYCacheCompletedBlock)completion{
    if (!path)return;
    dispatch_async(self.patchQueue, ^{
        
        NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
        for (NSString *fileName in fileEnumerator)
        {
            NSString *filePath = [path stringByAppendingPathComponent:fileName];
            
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(),^{
                completion();
            });
        }
    });
}



@end
