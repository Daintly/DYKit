//
//  NSString+DY.m
//  HSQ
//
//  Created by Dainty on 17/4/18.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import "NSString+DY.h"

@implementation NSString (DY)
- (NSURL *)DY_URL{
    return [NSURL URLWithString:self];
}
@end
