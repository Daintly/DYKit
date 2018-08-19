//
//  UIView+HUD.h
//  HiddView
//
//  Created by Dainty on 17/3/31.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
@interface UIView (HUD)

/**
 普通的显示
 */
- (void)show;
//旋转时下方显示内容
- (void)showWithStr:(NSString *)str;
/**
 消失
 */
- (void)dismiss;

/**
进度条
 */
- (void)showWithProgress;
//⚠️
- (void)showInfoWithStr;
//加载成功
- (void)showSuccessWithStr:(NSString *)str;
//加载失败
- (void)showErrorWithStr:(NSString *)str;
//自定义SV的帧动画
- (void)showImageStatus:(NSString *)status;
/**
 当无数据时或有其他情况隐藏HUD

 @param timer 时间（s）
 */
- (void)afterDismissTimer:(NSTimeInterval)timer;
@end
