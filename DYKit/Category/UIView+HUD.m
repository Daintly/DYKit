//
//  UIView+HUD.m
//  HiddView
//
//  Created by Dainty on 17/3/31.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)
//- (void)show{
//    /*
//     Style指的是背景颜色，背景色与前景色相反。
//     
//     typedef NS_ENUM(NSInteger, SVProgressHUDStyle) {
//     SVProgressHUDStyleLight,        // default style, white HUD with black text, HUD background will be blurred on iOS 8 and above
//     SVProgressHUDStyleDark,         // black HUD and white text, HUD background will be blurred on iOS 8 and above
//     SVProgressHUDStyleCustom        // uses the fore- and background color properties
//     };*/
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    /*AnimationType指的是动画类型，只对 "show" 和 "showWithStatus" 有效
//    
//    typedef NS_ENUM(NSUInteger, SVProgressHUDAnimationType) {
//        SVProgressHUDAnimationTypeFlat,     // default animation type, custom flat animation (indefinite animated ring)
//        SVProgressHUDAnimationTypeNative    // iOS native UIActivityIndicatorView
//    };
//     */
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
//    [SVProgressHUD show];
//}
//-(void)showWithStr:(NSString *)str{
//
// 
//    [SVProgressHUD showWithStatus:str];
//    
// //[self afterDismissTimer:2];
//   
//}
- (void)dismiss{
    [SVProgressHUD dismiss];
}
   static float progress = 0.0f;
- (void)showWithProgress{
    progress = 0.0f;
    [SVProgressHUD showProgress:0 status:@"DY"];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.1f];
}
- (void)increaseProgress{
 
    progress += 0.1f;
    [SVProgressHUD showProgress:progress status:@"DY"];
    if (progress < 1.0f) {
         [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    }else{
          [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
    }
}
- (void)afterDismissTimer:(NSTimeInterval)timer{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, timer * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}
- (void)showSuccessWithStr:(NSString *)str{
    [SVProgressHUD showSuccessWithStatus:str];
        [self afterDismissTimer:2];
}
- (void)showErrorWithStr:(NSString *)str{
    [SVProgressHUD showErrorWithStatus:str];
    
    [self afterDismissTimer:2];
}
- (void)showInfoWithStr:(NSString *)str{
    [SVProgressHUD showInfoWithStatus:str];
}
- (void)showImageStatus:(NSString *)status{
    
    [SVProgressHUD setMinimumDismissTimeInterval:30];
    
    [SVProgressHUD setBackgroundColor:[UIColor DY_colorWithR255Red:1.0f green:1.0f blue:1.0f alpha:0.5f]];
//
   // [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
        [SVProgressHUD showImage:[UIImage imageWithGIFNamed:@"loading"] status:nil];
  
    
//     [self afterDismissTimer:2];
}
@end
