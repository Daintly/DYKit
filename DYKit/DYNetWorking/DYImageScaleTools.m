
//
//  DYImageScaleTools.m
//  DYImageScaleTool
//
//  Created by Dainty on 2019/2/13.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import "DYImageScaleTools.h"
/** 计算图像压缩所需时间 */
#import <mach/mach_time.h>

@implementation DYImageScaleTools
double MachTimeToScale(uint64_t time)
{
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)time * (double)timebase.numer /  (double)timebase.denom / 1e9;
}



+ (instancetype)shareInstance{
    
    static DYImageScaleTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DYImageScaleTools alloc] init];
    });
    
    return instance;
}



#pragma mark   ============ Public  Method

//仿微信压缩图像
+ (NSData *)reduceOfImageWithWeiChate:(UIImage *)source_Imaga  maxByte:(NSInteger)maxByte{
    
    
    CGFloat compression  = 1.0f;
    CGFloat minCompression = 0.5f;
    
    NSData *imageData = UIImageJPEGRepresentation(source_Imaga, compression);
    CGFloat imageFileSize = imageData.length / 1024;
    
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"原图大小：%lu kb",imageData.length / 1024);
    DYImageScaleTools *tool = [DYImageScaleTools shareInstance];
    UIImage *newImage = [tool CompresImage:source_Imaga];
    //每次减少的比例
    float scale = 0.05;
    //循环条件：没到最小压缩比例,且没压缩到目标大小
    while ((compression > minCompression)&&(imageFileSize > maxByte)) {
        compression -= scale;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
  NSLog(@"压缩时间: %.4lf s,  压缩后图片大小: %lu Kb", linkTime, (unsigned long)imageData.length/1024);
    return imageData;
    
}

+(NSData *)reduceOfImageWithTwoPoint:(UIImage *)souce_image maxByte:(NSInteger)maxByte{
    //先判断当前质量是否满足要求，不满足在进行压缩
    
    __block NSData *finallImageData = UIImageJPEGRepresentation(souce_image, 1.0);
    NSUInteger sizeOrigin = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin/ 1024;
    if (sizeOriginKB <= maxByte) {
        return finallImageData;
    }
    DYImageScaleTools *tool = [DYImageScaleTools shareInstance];
    uint64_t begin = mach_absolute_time();
    NSLog(@"原图大小 = %lu kb",(unsigned long)finallImageData.length /1024);
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024 , 1024);
    UIImage *newImage = [tool newSizeImage:defaultSize image:souce_image];
    finallImageData = UIImageJPEGRepresentation(newImage, 1.0);
    //保存压缩系数
    NSMutableArray *reduceQualityArr = [NSMutableArray array];
    CGFloat avg = 1.0 / 250;
    CGFloat value = avg;
    for (int i = 250 ; i >= 1; i--) {
        value = i * avg;
        [reduceQualityArr addObject:@(value)];
    }
    /**调整大小 压缩s系数数组是从大到小存储*/
    finallImageData = [tool halfFuntion:reduceQualityArr image:newImage sourceData:finallImageData maxSize:maxByte];
    //如果还是未能压缩到指定大小，则降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        if (defaultSize.width - 100 <= 0 || defaultSize.height - 100<=0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width - 100, defaultSize.height - 100);
        UIImage *image = [tool newSizeImage:defaultSize image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage, [[reduceQualityArr lastObject] floatValue])]];
        finallImageData = [tool halfFuntion:reduceQualityArr image:image sourceData:UIImageJPEGRepresentation(image, 1.0) maxSize:maxByte];
    }
    
    uint64_t end = mach_absolute_time();
    NSLog(@"压缩时间  = %g s,  压缩后图片大小 = %lu Kb", MachTimeToScale(end - begin), (unsigned long)finallImageData.length/1024);
    
    return finallImageData;
}


/** 二分法压缩 */

- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        
        //        NSLog(@"当前降到的质量 -> %ld 压缩系数 -> %lg", (unsigned long)sizeOriginKB,  [arr[index] floatValue]);
        
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}



/**
 等比例缩小图像压缩

 @param source_Imaga <#source_Imaga description#>
 @param maxByte <#maxByte description#>
 @return <#return value description#>
 */
+ (NSData *)reduceOfImageWithEqualProportion:(UIImage *)source_Imaga  maxByte:(NSInteger)maxByte{
    
    CGFloat compression    = 1.0f;
    CGFloat minCompression = 0.5f;
    NSData *imageData = UIImageJPEGRepresentation(source_Imaga, compression);
    NSLog(@"原图大小 = %lu kb",(unsigned long)imageData.length / 1024);
    CGFloat imageFileSize = imageData.length / 1024;
    DYImageScaleTools *tool = [DYImageScaleTools shareInstance];
    UIImage *newImage = [tool scaleToWidth:1242 scaleImage:source_Imaga];
    uint64_t begin = mach_absolute_time();
    //每次减少的比例
    float scale = 0.05;
    while ((compression > minCompression) && imageFileSize > maxByte)  {
        compression -= scale;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    uint64_t end = mach_absolute_time();
     NSLog(@"压缩时间  = %g s,  压缩后图片大小 = %lu Kb", MachTimeToScale(end - begin), (unsigned long)imageData.length/1024);
    return imageData;
    
}

/** 在原有基础上图像等比例缩放 */

- (UIImage *)scaleToWidth:(CGFloat)width scaleImage:(UIImage *)image
{
    if (width > image.size.width) {
        return  image;
    }
    CGFloat height = (width / image.size.width) * image.size.height;
    CGRect  rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




- (UIImage *)CompresImage:(UIImage *)image{
    CGSize size = [self compressSizeImage:image];
    UIImage *reImage = [self resizedImage:size image:image];
    return reImage;
}



- (UIImage *)resizedImage:(CGSize)newSize image:(UIImage *)image{
    CGRect newRect = CGRectMake(0, 0, newSize.width, newSize.height);
    UIGraphicsBeginImageContext(newRect.size);
    
    UIImage *newImage = [[UIImage alloc] initWithCGImage:image.CGImage scale:1 orientation:image.imageOrientation];
    [newImage drawInRect:newRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (CGSize)compressSizeImage:(UIImage *)image{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat boundary = 1280;
    if (width < boundary && height < boundary) {
        return CGSizeMake(width, height);
    }
    CGFloat ratio = MAX(width, height) / MIN(width, height);
    if (ratio <= 2) {
        CGFloat x = MAX(width, height) / boundary;
        if (width > height) {
            width = boundary;
            height = height / x;
        }else{
            height = boundary;
            width = width / x;
        }
    }else{
        if (MIN(width, height) >= boundary) {
            CGFloat x = MIN(width, height) / boundary;
            if (width < height) {
                width = boundary;
                height = height / x;
            }else{
                height = boundary;
                width = width / x;
            }
        }
    }
    return CGSizeMake(width, height);
    
    
}
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)source_image{
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

