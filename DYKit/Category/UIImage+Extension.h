//
//  UIImage+Extension.h
//  DaintyKit
//
//  Created by Dainty on 17/2/20.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIImage (Extension)


//字符串转图片
+(UIImage*)Base64StrToUIImage:(NSString*)encodedImageStr;


- (void)dy_imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void(^)(UIImage *image))completion;

- (void)dy_imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion;
/**
 *根据尺寸 和颜色 绘制图片
 */
+ (UIImage*)dy_imageWithColor:(UIColor*)color size:(CGSize)size;


/**
 *  尺寸 文字 颜色  字体 绘制头像 例：钉钉通讯录头像 默认为15号字体
 **/
+ (UIImage *)dy_circleImageWithText:(NSString *)text setColor:(UIColor *)setColor size:(CGSize)size fontSize:(NSInteger)fontSize textColor:(UIColor *)textColor;

@end
