//
//  NSString+DYUTF8Encoding.m
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import "NSString+DYUTF8Encoding.h"
#import <UIKit/UIKit.h>
@implementation NSString (DYUTF8Encoding)
+ (NSString *)dy_stringUTF8Encoding:(NSString *)urlString{
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
        return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else{
        return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

+ (NSString *)dy_urlString:(NSString *)urlString appendingParameters:(id)parameters{
    if (parameters == nil) {
        return urlString;
    }else{
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSString *key in parameters) {
            id obj = [parameters objectForKey:key];
            NSString *str = [NSString stringWithFormat:@"%@=%@",key,obj];
            [array addObject:str];
        }
        NSString *parameterString = [array componentsJoinedByString:@"&"];
        return [urlString stringByAppendingString:[NSString stringWithFormat:@"?%@",parameterString]];
    }
}

@end
