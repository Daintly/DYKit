//
//  UIImage+Extension.m
//  DaintyKit
//
//  Created by Dainty on 17/2/20.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (void)dy_imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion{
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
- (void)dy_imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion{
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



+ (UIImage*)dy_imageWithColor:(UIColor*)color size:(CGSize)size {
    
    if(!color || size.width<=0|| size.height<=0)return nil;
    CGRect rect =CGRectMake(0.0f,0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)dy_circleImageWithText:(NSString *)text setColor:(UIColor *)setColor size:(CGSize)size fontSize:(NSInteger)fontSize textColor:(UIColor *)textColor{
    
    
    NSDictionary *fontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize?fontSize:15], NSForegroundColorAttributeName: textColor};
    CGSize textSize = [text sizeWithAttributes:fontAttributes];
    CGPoint drawPoint = CGPointMake((size.width - textSize.width)/2, (size.height - textSize.height)/2);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    CGContextSetFillColorWithColor(ctx, setColor.CGColor);
    [path fill];
    [text drawAtPoint:drawPoint withAttributes:fontAttributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
}

@end
