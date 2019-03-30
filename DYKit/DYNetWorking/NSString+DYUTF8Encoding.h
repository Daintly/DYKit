//
//  NSString+DYUTF8Encoding.h
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DYUTF8Encoding)

/**
 UTF8
 
 @param urlString 编码前的url字符串
 @return 返回 编码后的url字符串
 */
+ (NSString *)dy_stringUTF8Encoding:(NSString *)urlString;

/**
 url字符串与parameters参数的的拼接
 
 @param urlString url字符串
 @param parameters parameters参数
 @return 返回拼接后的url字符串
 */
+ (NSString *)dy_urlString:(NSString *)urlString appendingParameters:(id)parameters;
@end

NS_ASSUME_NONNULL_END
