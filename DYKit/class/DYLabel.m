//
//  DYLabel.m
//  DYKit
//
//  Created by Dainty on 2018/8/14.
//  Copyright © 2018年 DAINTY. All rights reserved.
//

#import "DYLabel.h"

@implementation DYLabel

-(void) drawTextInRect:(CGRect)rect {
    //从将文本的绘制Rect宽度缩短半个字体宽度
    //self.font.pointSize / 2
    return [super drawTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - self.font.pointSize / 2, rect.size.height)];
}

@end
