//
//  DYRequestManager.h
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYRequestConst.h"
#import "DYRequestConfig.h"

@interface DYRequestManager : NSObject



/**
 请求方法 GET/POST/PUT/PATCH/DELETE

 @param config 请求b配置block
 @param success 请求成功block
 @param failure 请求失败block
 */
+(void)requestWithConfig:(requestConfig)config success:(requestSuccess)success failure:(requestFailure)failure;
/**
 *  请求方法 GET/POST/PUT/PATCH/DELETE/Upload/DownLoad
 *
 *  @param config           请求配置  Block
 *  @param progress         请求进度  Block
 *  @param success          请求成功的 Block
 *  @param failure          请求失败的 Block
 */
+ (void)requestWithConfig:(requestConfig)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure;
/**
 *  请求方法 仅适用上传图片
 *
 *  @param config           请求配置  Block
 *  @param progress         请求进度  Block
 *  @param success          请求成功的 Block
 *  @param failure          请求失败的 Block
 */
+ (void)requestUploadImageWithConfig:(requestConfig)config progress:(progressBlock)progress success:(requestSuccess)success failure:(requestFailure)failure;
@end


