//
//  DYImageScaleTools.h
//  DYImageScaleTool
//
//  Created by Dainty on 2019/2/13.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DYImageScaleTools : NSObject
+ (instancetype)shareInstance;

//仿微信压缩图像
+ (NSData *)reduceOfImageWithWeiChate:(UIImage *)source_Imaga  maxByte:(NSInteger)maxByte;
+(NSData *)reduceOfImageWithTwoPoint:(UIImage *)souce_image maxByte:(NSInteger)maxByte;
/**
 等比例缩小图像压缩
 
 @param source_Imaga 目标image
 @param maxByte 最大图片字节
 @return 二进制图片
 */
+ (NSData *)reduceOfImageWithEqualProportion:(UIImage *)source_Imaga  maxByte:(NSInteger)maxByte;
    
@end

NS_ASSUME_NONNULL_END
