//
//  DYAuthorizationTool.h
//  HSQ
//
//  Created by Dainty on 17/4/6.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, DYAuthorizationStatus) {
       DYAuthorizationStatusAuthorized   = 0,   //已授权
     DYAuthorizationStatusDenied,                //已拒绝
    DYAuthorizationStatusRestricted,             //应用没有相关权限，且当前用户无法改变这个权限
        DYAuthorizationStatusNotDetermined ,      //未授权
    DYAuthorizationStatusNotSupport                //硬件不支持，（该处是自己加的）
};
@interface DYAuthorizationTool : NSObject

/**
 请求访问相册

 @param callback <#callback description#>
 */
+(void)requestImagePickerAuthorization:(void (^)(DYAuthorizationStatus status))callback;
@end
