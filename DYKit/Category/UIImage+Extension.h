//
//  UIImage+Extension.h
//  DaintyKit
//
//  Created by Dainty on 17/2/20.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


//字符串转图片
+(UIImage*)Base64StrToUIImage:(NSString*)encodedImageStr;


- (void)DY_imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void(^)(UIImage *image))completion;

- (void)dj_imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion;
@end
