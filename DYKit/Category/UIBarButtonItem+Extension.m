//
//  UIBarButtonItem+Extension.m
//  DaintyKit
//
//  Created by Dainty on 17/2/21.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)


+ (instancetype)initWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
    btn.size = CGSizeMake(15, 15);
    btn.contentMode = UIViewContentModeScaleAspectFill;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
    
}
@end
