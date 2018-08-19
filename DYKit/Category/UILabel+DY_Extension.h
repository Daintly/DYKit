//
//  UILabel+DY_Extension.h
//  HSQ
//
//  Created by Dainty on 17/3/13.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DY_Extension)


/**
 * 功能：UILabel 字体设置

label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];//加粗
label.font = [UIFont fontWithName:@"Helvetica-Oblique" size:20];//加斜
label.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:20];//又粗又斜
+ (instancetype)initWithFontSize:(CGFloat)fontSize numberOfLines: (NSInteger)numberOfLines;
 */

+ (instancetype)initWithFontSize:(CGFloat)fontSize numberOfLines: (NSInteger)numberOfLines textColor:(NSString *)hex;
//是否首行缩进 多少字符

/**
 @param fontSize 字体像数大小
 @param numberOfLines 行数
 @param hexY 16进制字符串
 @param paraStyleSize 缩进像数大小
 @return label
 */
+ (instancetype)paraStyleWithFontSize:(CGFloat)fontSize numberOfLines: (NSInteger)numberOfLines textColor:(NSString *)hexY paraStyleSize:(CGFloat)paraStyleSize;


/**
 截取最后一行字符串
 */
- (void)setLineBreakByTruncatingLastLineMiddle;
- (NSArray *)getSeparatedLinesFromLabel;
- (NSArray *)getSeparatedLinesArray;
//图片在后
- (void)setText:(NSString *)text frontImages:(NSArray<UIImage *> *)images imageSpan:(CGFloat)span;
- (void)setText:(NSString *)text
    imageSize:(CGFloat)imageSize frontImages:(NSArray<UIImage *> *)images imageSpan:(CGFloat)span;
- (void)leftPicSetText:(NSString *)text frontImages:(NSArray<UIImage *> *)images imageSpan:(CGFloat)span;
//图片在左 设置图片大小
- (void)leftPicWithText:(NSString *)text imageSize:(CGFloat)imageSize frontImages:(NSArray<UIImage *> *)images imageSpan:(CGFloat)span;
@end
