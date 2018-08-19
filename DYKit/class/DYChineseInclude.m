//
//  DYChineseInclude.m
//  HSQ
//
//  Created by Dainty on 17/5/23.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import "DYChineseInclude.h"

@implementation DYChineseInclude
+ (BOOL)isIncludeChineseInString:(NSString*)str {
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}
@end
