//
//  JKCustomButton.m
//  HYBS
//
//  Created by Dainty on 2018/3/21.
//  Copyright © 2018年 DAINTY. All rights reserved.
//

#import "JKCustomButton.h"

@implementation JKCustomButton

- (void)setRightspacing:(CGFloat)spacing
{
    CGFloat space = spacing;
    CGFloat titleW = CGRectGetWidth(self.titleLabel.bounds);
    CGFloat titleH = CGRectGetHeight(self.titleLabel.bounds);
    
    CGFloat imageW = CGRectGetWidth(self.imageView.bounds);
    CGFloat imageH = CGRectGetHeight(self.imageView.bounds);
    
    CGFloat btnCenterX = CGRectGetWidth(self.bounds)/2;
    CGFloat imageCenterX = btnCenterX - titleW/2;
    CGFloat titleCenterX = btnCenterX + imageW/2;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(imageH/2+ space/2, -(titleCenterX-btnCenterX), -(imageH/2 + space/2), titleCenterX-btnCenterX);
    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleH/2 + space/2), btnCenterX-imageCenterX, titleH/2+ space/2, -(btnCenterX-imageCenterX));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setRightspacing:3];
}

@end
