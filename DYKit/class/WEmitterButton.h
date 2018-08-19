//
//  WEmitterButton.h
//  WEmitterButton
//
//  Created by 王王亚 on 16/12/1.
//  Copyright © 2016年 王亚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
typedef NS_ENUM(NSInteger, WButtonType) {
    WButtonTypeImageUp = 0,        // 图片在上
    WButtonTypeImageDown = 1,      // 图片在下
    BWButtonTypeImageLeft = 2,      // 图片在左边
    WButtonTypeImageRight = 3,     // 图片在右边
    WButtonTypeDefault = BWButtonTypeImageLeft,
};

@interface WEmitterButton : UIButton

/**
 *  初始化方法
 *
 *  @param type 类型
 *  @param spacing 间距
 *
 *  @return 实例对象
 */
- (instancetype)initWithType:(WButtonType)type spacing:(CGFloat)spacing;

@end
