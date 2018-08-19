//
//  UIImage+Extension.m
//  DaintyKit
//
//  Created by Dainty on 17/2/20.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (void)DY_imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //开始时间
        NSTimeInterval start = CACurrentMediaTime();
        //利用绘图，建立上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        //利用贝塞尔曲线路径裁切效果
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        //填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        //裁切
        [path addClip];
        //3绘制图像
        [self drawInRect:rect];
        //4取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
         NSLog(@"%f",CACurrentMediaTime() - start);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}
- (void)dj_imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //开始时间
        NSTimeInterval start = CACurrentMediaTime();
        //利用绘图，建立上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        //利用贝塞尔路径裁切效果
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        //填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        //裁切
        [path addClip];
        //3绘制图像
        [self drawInRect:rect];
        //4取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        NSLog(@"%f",CACurrentMediaTime() - start);
        //7完成回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
    
    
}


+(UIImage*)Base64StrToUIImage:(NSString*)encodedImageStr
{
    NSData *decodedImageData = [[NSData alloc]
                                initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

@end
