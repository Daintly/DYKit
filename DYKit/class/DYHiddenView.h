//
//  DYHiddenView.h
//  HSQ
//
//  Created by Dainty on 17/3/30.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYHiddenView : UIView

/**
 弹出框中间

 @param message 文本内容
 @param time 几秒后隐藏
 */
+ (void)showCenterMessage:( NSString *)message time:(NSTimeInterval)time;


/**
 弹出框 中有图片


 */


+ (void)showCenterWithMessage:(NSString *)message time:(NSTimeInterval)time imageStr:(NSString*)imageStr;
@end
