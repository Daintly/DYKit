//
//  NSString+DY_Size.h
//  HSQ
//
//  Created by Dainty on 17/3/14.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DY_Size)

/**
 * 计算文字高度，可以处理计算带行间距的等属性
 */
- (CGSize)boundingRectWithSize:(CGSize)size paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle font:(UIFont*)font;
///**
// * 计算文字高度，可以处理计算带行间距的
// */
//- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
///**
// * 计算最大行数文字高度，可以处理计算带行间距的
// */
//- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines;
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;
@end
