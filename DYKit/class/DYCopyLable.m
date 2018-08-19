//
//  DYCopyLable.m
//  HYBS
//
//  Created by Dainty on 2018/3/28.
//  Copyright © 2018年 DAINTY. All rights reserved.
//

#import "DYCopyLable.h"

@implementation DYCopyLable

//为了能接收到事件（能成为第一响应者），我们需要覆盖一个方法：

-(BOOL)canBecomeFirstResponder
{
    return YES;
}


//还需要针对复制的操作覆盖两个方法：

// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:));
}




//针对于响应方法的实现
-(void)copy:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}
@end
