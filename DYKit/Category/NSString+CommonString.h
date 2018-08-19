//
//  NSString+CommonString.h
//  DaintyKit
//
//  Created by Dainty on 17/2/20.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CommonString)


- (NSURL *)DY_URL;
- (NSURL *)DG_URL;

#pragma mark 匹配手机号码
+(BOOL)isMatch:(NSString *)str;

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard;
/**
 *  秒数时间转换
 */
+ (NSString *)distanceTimeWithBeforeTime:(double)time;
//时间戳转换时间
+ (NSString *)distanceFormatterWithTime:(double)time;

//时间戳转换时间 年月日时分
+ (NSString *)distanceFormatterWithHHSSTime:(double)time;
//时间戳转换时间 年月日时分 秒
+ (NSString *)distanceFormatterWithHHMMSSTime:(double)time;
//获取当前时间戳
+(NSString *)currentTimeStr;


/**
 *  过滤HTML标签
 */
+ (NSString *)removeStringIntheHTML:(NSString *)html;

/**
 *  随机验证码字符串
 */
+ (NSString *)RandomString:(double)number;

/**
 *  判断用户输入是否含有emoji
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  过滤emoji
 */
+ (NSString *)removeStringIntheEmoji:(NSString *)string;

/**
 *  查看当前版本号
 */
+ (NSString *)getAppVersion;

/**
 *  获取App的build版本
 */
+ (NSString *)getappBuildVersion;

/**
 *  获取App名称
 */
+ (NSString *)getappName;

/**
 *  判断是否为手机号码
 */
+ (BOOL)isValidPhoneWithString:(NSString *)phoneString;

/**
 * 判断字符串是否包含空格
 */
+ (BOOL)isBlank:(NSString *)str;

/**
 *  判断字符串中是否含有非法字符
 */
+ (BOOL)isContainErrorCharacter:(NSString *)content;

/**
 *  判断字符串中包含空格换行
 */
+ (BOOL)isEmpty:(NSString* )string;

/**
 *  截取字符串中的数字
 */
+ (NSString *)getPhoneNumberFomat:(NSString *)number;
//UIimage装base64的字符串
+(NSString*)UIImageToBase64Str:(UIImage*)image;
//通过富文本去掉标签
//将HTML字符串转化为NSAttributedString富文本字符串
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString;


//拼接USER_
+ (NSString *)addString:(NSString *)str;
//截取USER_
+ (NSString *)deleteString:(NSString *)str;
//设置行间距 和字符间距
- (NSAttributedString *)getAttributedStringWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern;
@end
