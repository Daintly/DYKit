//
//  UIView+dy_CornerRadius.h
//  UITableView
//
//  Created by Dainty on 2018/9/13.
//  Copyright © 2018年 DAINTY. All rights reserved.
//




#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

/**
 绘制一个圆角的view

 @param radius 圆角大小
 @param size view大小
 */
- (void)dy_addRounderCornerWithRadius:(CGFloat)radius size:(CGSize)size;

@end
