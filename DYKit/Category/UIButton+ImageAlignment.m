//
//  UIButton+ImageAlignment.m
//  DaintyKit
//
//  Created by Dainty on 17/2/20.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import "UIButton+ImageAlignment.h"
#import <objc/runtime.h>

@interface UIButton()
@property (nonatomic, assign) NSTimeInterval custom_acceptEventTime;
@end
@implementation UIButton (ImageAlignment)

+ (void)load{
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL  = @selector(sendAction:to:forEvent:);
    Method customMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    
    //添加方法 语法：BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types) 若添加成功则返回No
    // cls：被添加方法的类  name：被添加方法方法名  imp：被添加方法的实现函数  types：被添加方法的实现函数的返回值类型和参数类型的字符串
    
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod),method_getTypeEncoding(customMethod));
    //如果系统中改方法已经存在了，则替换系统的方法，语法 IMP class_replaceMethod(Class cls, SEL name, IMP imp,const char *types)
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }
}


- (NSTimeInterval)custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval")doubleValue];
}
- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)custom_acceptEventTime{
     return [objc_getAssociatedObject(self, "UIControl_acceptEventTime")doubleValue];
}
- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
      objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    // 如果想要设置统一的间隔时间，可以在此处加上以下几句
    // 值得提醒一下：如果这里设置了统一的时间间隔，会影响UISwitch,如果想统一设置，又不想影响UISwitch，建议将UIControl分类，改成UIButton分类，实现方法是一样的
    // if (self.custom_acceptEventInterval <= 0) {
    //     // 如果没有自定义时间间隔，则默认为2秒
    //    self.custom_acceptEventInterval = 2;
    // }
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
}
- (void)layoutButtonWithEdgeInsetsStyle:(DYImageAlignment)style
                        imageTitleSpace:(CGFloat)space
{
    //    self.backgroundColor = [UIColor cyanColor];
    
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width ;
    CGFloat imageHeight = self.imageView.frame.size.height ;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case DYButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case DYButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case DYButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case DYButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
- (void)layoutButtonSizeWithEdgeInsetsStyle:(DYImageAlignment)style imageTitleSpace:(CGFloat)space imageTopEdg:(CGFloat)imageTopSpace  imageBottomEdg:(CGFloat)imageBottomSpace
{
    //    self.backgroundColor = [UIColor cyanColor];
    
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    CGFloat imageWith = self.imageView.frame.size.width ;
    CGFloat imageHeight = self.imageView.frame.size.height ;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case DYButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case DYButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(imageTopSpace, -space/2.0, imageBottomSpace, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case DYButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case DYButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(imageTopSpace, labelWidth+space/2.0, imageBottomSpace, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}



+ (instancetype)initWithTitle:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor highTitleColor:(UIColor *)highTitleColor normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage target:(id)target selected:(SEL)selected{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [btn setTitleColor:highTitleColor forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [btn addTarget:target action:selected forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+(instancetype)initWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return btn;
}

+ (instancetype)initWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    // [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //    [btn sizeToFit];
    [btn setFrame:frame];
    // btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // btn.frame = frame;
    return btn;
}
+ (instancetype)hexWithTitle:(NSString *)title font:(CGFloat)font norHexColor:(NSString*)norHexeColor seletedHexColor:(NSString *) seletedHexColor target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor DY_colorWithHexString:norHexeColor] forState:UIControlStateNormal];
    
     [btn setTitleColor:[UIColor DY_colorWithHexString:seletedHexColor] forState:UIControlStateSelected];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:FontSize(font)];
       [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  btn;

}
@end
