//
//  UIButton+ImageAlignment.h
//  DaintyKit
//
//  Created by Dainty on 17/2/20.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DYImageAlignment){

        DYButtonEdgeInsetsStyleTop, // image在上，label在下
        DYButtonEdgeInsetsStyleLeft, // image在左，label在右
        DYButtonEdgeInsetsStyleBottom, // image在下，label在上
        DYButtonEdgeInsetsStyleRight // image在右，label在左
};
@interface UIButton (ImageAlignment)
@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;//可以用这个给重复点击加间隔

/**
 *  设置Button文字和图片的方向和距离
 *
 *  @param type     图片所在的方向(上、下、左、右)
 *  @param range    图片和文字的距离
 /**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(DYImageAlignment)style
                        imageTitleSpace:(CGFloat)space;

/*
 *  设置Button文字和图片的方向和距离
 *
 *  @param type     图片所在的方向(上、下、左、右)
 *  @param range    图片和文字的距离
 /**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 
 imageTopEdg 图片拒上距离  （主要是为了调整，button里面图片小的情况下使用）
 imageBottomSpace  图片拒下距离
 */
- (void)layoutButtonSizeWithEdgeInsetsStyle:(DYImageAlignment)style imageTitleSpace:(CGFloat)space imageTopEdg:(CGFloat)imageTopSpace  imageBottomEdg:(CGFloat)imageBottomSpace;
/**
 *  设置带图片的 Button (带方法)
 *
 *  @param title                文字
 *  @param normalTitleColor           默认文字颜色
 *  @param highTitleColor     高亮文字颜色
 *  @param normalImage             默认图片
 *  @param selectedImage       高亮图片
 *  @param selected              点击后做的事情
 */
+ (instancetype)initWithTitle:(NSString *)title normalTitleColor:(UIColor*)normalTitleColor highTitleColor:(UIColor *)highTitleColor normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage target:(id)target selected:(SEL)selected;

+ (instancetype)initWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action frame:(CGRect)frame;
+(instancetype)initWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action;
/**
 16进制文本颜色 自适应字体大小

 @param title <#title description#>
 @param font <#font description#>
 @param norHexeColor <#norHexeColor description#>
 @param seletedHexColor <#seletedHexColor description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
+ (instancetype)hexWithTitle:(NSString *)title font:(CGFloat)font norHexColor:(NSString*)norHexeColor seletedHexColor:(NSString *) seletedHexColor target:(id)target action:(SEL)action;

@end
