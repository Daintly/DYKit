//
//  UIColor+DY_Extension.h
//  HSQ
//
//  Created by Dainty on 17/3/14.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DY_Extension)
// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor *)DY_colorWithHex:(long)hexColor;
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)DY_colorWithHex:(long)hexColor alpha:(float)opacity;
// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *) DY_colorWithHexString: (NSString *)color;

+ (UIColor *)DY_colorWithR255Red:(CGFloat)r green:(CGFloat)g blue:(CGFloat)r alpha:(CGFloat)a;
+ (UIColor *)DY_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b ;
@end
