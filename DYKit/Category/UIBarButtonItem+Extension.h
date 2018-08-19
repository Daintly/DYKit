//
//  UIBarButtonItem+Extension.h
//  DaintyKit
//
//  Created by Dainty on 17/2/21.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype) initWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
