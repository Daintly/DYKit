//
//  JKCopyField.m
//  HYBS
//
//  Created by Dainty on 2018/3/28.
//  Copyright © 2018年 DAINTY. All rights reserved.
//

#import "JKCopyField.h"

@implementation JKCopyField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(action));
    
    if (action == @selector(cut:) || action == @selector(copy:)) {
        return NO;
    }
    
    return YES;
}


@end
