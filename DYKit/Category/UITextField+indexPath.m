//
//  UITextField+indexPath.m
//  HSQ
//
//  Created by Dainty on 17/5/3.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import "UITextField+indexPath.h"
#import <objc/runtime.h>

static char indexPathKey;
@implementation UITextField (indexPath)
- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &indexPathKey);
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
