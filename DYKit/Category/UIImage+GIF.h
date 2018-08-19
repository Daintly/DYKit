//
//  UIImage+GIF.h
//  富文本
//
//  Created by Dainty on 17/6/28.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GIFimageBlock)(UIImage *GIFImage);  
@interface UIImage (GIF)

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;
@end
