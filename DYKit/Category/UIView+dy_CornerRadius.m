//
//  UIView+dy_CornerRadius.m
//  UITableView
//
//  Created by Dainty on 2018/9/13.
//  Copyright © 2018年 DAINTY. All rights reserved.
//

#import "UIView+dy_CornerRadius.h"

@implementation UIView (CornerRadius)
- (void)dy_addRounderCornerWithRadius:(CGFloat)radius size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(cxt, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(cxt, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(cxt, size.width, size.height-radius);
    CGContextAddArcToPoint(cxt, size.width, size.height, size.width-radius, size.height, radius);//右下角
    CGContextAddArcToPoint(cxt, 0, size.height, 0, size.height-radius, radius);//左下角
    CGContextAddArcToPoint(cxt, 0, 0, radius, 0, radius);//左上角
    CGContextAddArcToPoint(cxt, size.width, 0, size.width, radius, radius);//右上角
    CGContextClosePath(cxt);
    CGContextDrawPath(cxt, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    [self insertSubview:imageView atIndex:0];
}


@end
