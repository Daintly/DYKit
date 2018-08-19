//
//  DYAuthorizationTool.m
//  HSQ
//
//  Created by Dainty on 17/4/6.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import "DYAuthorizationTool.h"
#import <Photos/Photos.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

#import <AssetsLibrary/AssetsLibrary.h>
@implementation DYAuthorizationTool
+ (void)requestImagePickerAuthorization:(void (^)(DYAuthorizationStatus))callback{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary] || [UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]){
        if ([UIDevice currentDevice].systemVersion.floatValue > 9.0) {
            PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
            if (authStatus == PHAuthorizationStatusNotDetermined) {
                [self operationCallback:callback status:DYAuthorizationStatusAuthorized];
            }else{
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (status == PHAuthorizationStatusAuthorized){
                        //授权
                        [self operationCallback:callback status:DYAuthorizationStatusAuthorized];
                    }else if (status == PHAuthorizationStatusDenied){
                        //已拒绝
                        [self operationCallback:callback status:DYAuthorizationStatusDenied];
                    }else if(status == PHAuthorizationStatusRestricted){
                        //应用没有相关权限 如家长控制
                        [self operationCallback:callback status:DYAuthorizationStatusRestricted];
                        
                    }
                }];

            }
        }else{
            ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
            //未授权
            if (authStatus == ALAuthorizationStatusNotDetermined) {
                if ([UIDevice currentDevice].systemVersion.floatValue > 8.0){
                    [self operationCallback:callback status:DYAuthorizationStatusAuthorized];
                }else{
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                        if (status == PHAuthorizationStatusAuthorized){
                            //授权
                            [self operationCallback:callback status:DYAuthorizationStatusAuthorized];
                        }else if (status == PHAuthorizationStatusDenied){
                            //已拒绝
                            [self operationCallback:callback status:DYAuthorizationStatusDenied];
                        }else if(status == PHAuthorizationStatusRestricted){
                            //应用没有相关权限 如家长控制
                            [self operationCallback:callback status:DYAuthorizationStatusRestricted];
                        }
                    }];
                }
            }else if (authStatus == PHAuthorizationStatusAuthorized){
                //授权
                [self operationCallback:callback status:DYAuthorizationStatusAuthorized];
            }else if (authStatus == PHAuthorizationStatusDenied){
                //已拒绝
                [self operationCallback:callback status:DYAuthorizationStatusDenied];
            }else if(authStatus == PHAuthorizationStatusRestricted){
                //应用没有相关权限 如家长控制
                [self operationCallback:callback status:DYAuthorizationStatusRestricted];
                
            }
        }
        }
        else{
         [self operationCallback:callback status:DYAuthorizationStatusNotSupport];
    }


}
//执行时
+ (void)operationCallback:(void (^)(DYAuthorizationStatus))callback status:(DYAuthorizationStatus)status{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(status);
        }
    });
}
@end
