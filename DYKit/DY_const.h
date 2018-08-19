//
//  DY_const.h
//  DYKit
//
//  Created by Dainty on 2018/8/14.
//  Copyright © 2018年 DAINTY. All rights reserved.
//

#ifndef DY_const_h
#define DY_const_h

#define  kDevice [[UIDevice currentDevice].systemVersion doubleValue]
//当前导航 的高度
#define KnaviBarHeight self.navigationController.navigationBar.height
#define DYISiPhoneX [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f
//当前view 的宽度
#define KviewWidth  self.view.width

#define KstatusHeight [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f ? 40:20
//当前view 的高度
#define kviewHeight  self.view.height
//判断当前是否是X
#define  bottomHeight  [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f ? 88 :49
//当前屏幕 的宽度
#define KScreenW    [UIScreen mainScreen].bounds.size.width
//当前屏幕 的高度
#define KScreenH    [UIScreen mainScreen].bounds.size.height

//当前tabBar 的高度
#define KTabBarH    self.tabBarController.tabBar.height

/**
 *  相对4.0寸屏幕宽的自动布局
 */
#define KFiveWidth(value)       (long)((value)/320.0f * [UIScreen mainScreen].bounds.size.width)


/**
 *  相对4.0寸屏幕高的比例进行屏幕适配
 */
#define KFiveHeight(value)      (long)((value)/568.0f * [UIScreen mainScreen].bounds.size.height)


/**
 *  相对4.7寸屏幕宽的比例进行屏幕适配
 */
#define KSixWidth(value)       (long)((value)/375.0f * [UIScreen mainScreen].bounds.size.width)


/**
 *  相对4.7寸屏幕高的比例进行屏幕适配
 */
#define KSixHeight(value)      (long)((value)/667.0f * [UIScreen mainScreen].bounds.size.height)


/**
 *  相对5.5寸屏幕宽的比例进行屏幕适配
 */
#define KSixPWidth(value)      (long)((value)/414.0f * [UIScreen mainScreen].bounds.size.width)


/**
 *  相对5.5寸屏幕高的比例进行屏幕适配
 */
#define KSixPHeight(value)     (long)((value)/736.0f * [UIScreen mainScreen].bounds.size.height)


#define FontSize(size)  ((KScreenW / 375.0f) > 1 ? size * 1.07 : size)

#define  KviewBackColor  [UIColor DY_colorWithRed:243 green:245 blue:246]

#define kChatToolBarHeight 49
#endif /* DY_const_h */
