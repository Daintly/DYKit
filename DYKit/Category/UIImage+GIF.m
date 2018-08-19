//
//  UIImage+GIF.m
//  富文本
//
//  Created by Dainty on 17/6/28.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import "UIImage+GIF.h"
#import <ImageIO/ImageIO.h>
@implementation UIImage (GIF)
+ (UIImage *)imageWithGIFData:(NSData *)data
{
    if (!data) return nil;
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    } else {
        
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            
            // 拿出了Gif的每一帧图片
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            //Learning... 设置动画时长 算出每一帧显示的时长（帧时长）
            NSTimeInterval frameDuration = [UIImage sd_frameDurationAtIndex:i source:source];
            duration += frameDuration;
            
            // 将每帧图片添加到数组中
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            // 释放真图片对象
            CFRelease(image);
        }
        
        // 设置动画时长
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    // 释放源Gif图片
    CFRelease(source);
    
    return animatedImage;
}

+ (UIImage *)imageWithGIFNamed:(NSString *)name
{
    NSUInteger scale = (NSUInteger)[UIScreen mainScreen].scale;
    return [self GIFName:name scale:scale];
}

+ (UIImage *)GIFName:(NSString *)name scale:(NSUInteger)scale
{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    
    if (!imagePath) {
        
        (scale + 1 > 3) ? (scale -= 1) : (scale += 1);
        imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    }
    
    if (imagePath) {
        
        // 传入图片名(不包含@Nx)
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        return [UIImage imageWithGIFData:imageData];
        
    } else {
        
        imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        if (imagePath) {
            
            // 传入的图片名已包含@Nx or 传入图片只有一张 不分@Nx
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            return [UIImage imageWithGIFData:imageData];
        } else {
            
            // 不是一张GIF图片(后缀不是gif)
            return [UIImage imageNamed:name];
        }
    }
}

+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock
{
    NSURL *GIFUrl = [NSURL URLWithString:url];
    
    if (!GIFUrl) return;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSData *CIFData = [NSData dataWithContentsOfURL:GIFUrl];
        
        // 刷新UI在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            gifImageBlock([UIImage imageWithGIFData:CIFData]);
        });
    });
    
}

#pragma mark - <关于GIF图片帧时长(Learning...)>

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}
@end
