//
//  UITabBar+dy_badge.m
//  uuyu
//
//  Created by Dainty on 2019/2/27.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#import "UITabBar+dy_badge.h"
#import "DYCustomTabBarLb.h"

#define TabbarItemNums 5.0
@implementation UITabBar (dy_badge)

- (void)dy_showBadgeOnItemIndex:(int)index{
    [self dy_showBadgeOnItemIndex:index];
    //新建小红点
    UIView *badgeView = [UIView new];
    badgeView.tag = 666 + index;
    badgeView.layer.cornerRadius = 5.0f;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    
    float percentX = (index + 0.5) / TabbarItemNums;
    CGFloat x = ceil((percentX * tabFrame.size.width));
    CGFloat y = ceil((0.1 * tabFrame.size.height));
    badgeView.frame = CGRectMake(x, y, 10, 10);// 图形大小为10
    [self addSubview:badgeView];
}
    

- (void)dy_hideBadgeOnItemIndex:(int)index{
    [self dy_removeBadgeOnItemIndex:index];
}


- (void)dy_removeBadgeOnItemIndex:(int)index{
    for (UIView *subView in self.subviews) {
        if (subView.tag == 666 + index) {
            [((DYCustomTabBarLb *)subView).shapeLayer removeFromSuperlayer];
            [subView removeFromSuperview];
        }
    }

}

- (void)initUnreadCountLb:(CGRect)frame tag:(NSInteger)tag badgeValue:(int)baderValue{
    DYCustomTabBarLb *lb =[[DYCustomTabBarLb alloc] initWithFrame:frame];
    [self addSubview:lb];
    lb.tag = tag;
    lb.layer.cornerRadius = frame.size.height / 2; // 图形
    if (baderValue != 0) {
        lb.text = [NSString stringWithFormat:@"%d",baderValue];
    }
    
}

- (void)dy_showBadgeOnItemIndex:(int)index badgeValue:(int)badgeValue{
    [self dy_removeBadgeOnItemIndex:index];
    // 新建小红点
    
    
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    
    float percentX = (index + 0.5) / TabbarItemNums;
    CGFloat x = ceil(percentX * tabFrame.size.width) + 5;
    CGFloat y = ceil(0.1 * tabFrame.size.height) - 2;
    if (badgeValue < 10) {
        [self initUnreadCountLb:CGRectMake(x, y, 14, 14) tag:666 + index badgeValue:badgeValue];
    }
    if (badgeValue >= 10 && badgeValue < 100) {
        [self initUnreadCountLb:CGRectMake(x, y, 17, 14) tag:666 + index badgeValue:badgeValue];
    }
    if (badgeValue >= 100) {
        DYCustomTabBarLb *lb = [[DYCustomTabBarLb alloc] initWithFrame:CGRectMake(x, y, 20, 14)];
        lb.text = @"99+";
        [self addSubview:lb];
        lb.tag = 666 + index;
    }
    
    
    
    
}

- (void)dy_showBadgeOnItemIndex:(int)index badgeValue:(int)badgeValue smallValue:(BOOL)smallValue{
    
    //移除之前的小红点
    
    [self dy_removeBadgeOnItemIndex:index];
    
    //新建小红点
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    float percentX = (index + 0.5) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width)+5;
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    if (smallValue == YES) {
        [self initUnreadCountLb:CGRectMake(x, y, 10, 10) tag:888 + index badgeValue:badgeValue];
    }else{
        
        if (badgeValue < 10) {
            [self initUnreadCountLb:CGRectMake(x, y, 14, 14) tag:888 + index badgeValue:badgeValue];
            
              [self initUnreadCountLb:CGRectMake(x, y, 14, 14) tag:666 + index badgeValue:badgeValue];
            
        }
        if (badgeValue >= 10 && badgeValue < 100) {
            [self initUnreadCountLb:CGRectMake(x, y, 17, 14) tag:666 + index badgeValue:badgeValue];
        }
        if (badgeValue >= 100) {
            DYCustomTabBarLb *lb = [[DYCustomTabBarLb alloc] initWithFrame:CGRectMake(x, y, 20, 14)];
         
            lb.text = @"99+";
            [self addSubview:lb];
            lb.tag = 888 + index;
            
        }
    }
    
}
@end
