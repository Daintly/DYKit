//
//  UITabBar+dy_badge.h
//  uuyu
//
//  Created by Dainty on 2019/2/27.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UITabBar (dy_badge)
//重写是为了修改badge小红点儿的颜色
- (void)dy_showBadgeOnItemIndex:(int)index; //显示小红点

- (void)dy_showBadgeOnItemIndex:(int)index badgeValue:(int)badgeValue; //显示带badge的红点

- (void)dy_showBadgeOnItemIndex:(int)index badgeValue:(int)badgeValue  smallValue:(BOOL)smallValue; //默认不显示带小红点;

- (void)dy_hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end


