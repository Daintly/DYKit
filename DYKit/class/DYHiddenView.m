//
//  DYHiddenView.m
//  HSQ
//
//  Created by Dainty on 17/3/30.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import "DYHiddenView.h"
#define  HiddenImageH  50.0f
#define HiddenImageW  50.0f
#import "DY_const.h"
@implementation DYHiddenView


+ (void)showCenterMessage:(NSString *)message time:(NSTimeInterval)time{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    showView.frame = CGRectMake(1,1,1, 1);
    showView.backgroundColor = [UIColor blackColor];
    showView.alpha = 1.0f;
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    UILabel *lb = [[UILabel alloc] init];
    CGSize szie = CGSizeMake(MAXFLOAT,0);
    lb.text = message;
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:FontSize(16)]};
    CGSize lableSize = [message boundingRectWithSize:szie options: NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    lb.frame = CGRectMake(FontSize(10), FontSize(5), lableSize.width , lableSize.height);
    lb.textColor =[ UIColor whiteColor];
    [lb sizeToFit];
    [showView addSubview:lb];
    showView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - lableSize.width - FontSize(20) ) / 2, ([UIScreen mainScreen].bounds.size.height - lableSize.height - FontSize(10)) / 2, lb.frame.size.width + FontSize(20) , lb.frame.size.height + FontSize(10));
    [UIView animateWithDuration:time animations:^{
        showView.alpha = 0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];

 }

+ (void)showCenterWithMessage:(NSString *)message time:(NSTimeInterval)time imageStr:(NSString *)imageStr{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    showView.frame = CGRectMake(1,1,1, 1);
    showView.backgroundColor = [UIColor blackColor];
    showView.alpha = 1.0f;
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = [UIImage imageNamed:imageStr];
    iv.frame = CGRectMake(0,0,HiddenImageW, HiddenImageH);
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [showView addSubview:iv];
    UILabel *lb = [[UILabel alloc] init];
    CGSize szie = CGSizeMake(MAXFLOAT,0);
    lb.text = message;
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:FontSize(16)]};
    CGSize lableSize = [message boundingRectWithSize:szie options: NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    CGFloat w;
    if (lableSize.width + FontSize(20)> HiddenImageW) {
        w  = lableSize.width + FontSize(20);
    }else{
        w = HiddenImageW;
    }

    lb.frame = CGRectMake(FontSize(10), FontSize(5) + HiddenImageH, w , lableSize.height);
    lb.textColor =[ UIColor whiteColor];
    lb.textAlignment = NSTextAlignmentCenter;
    [lb sizeToFit];
    [showView addSubview:lb];

    showView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - w ) / 2, ([UIScreen mainScreen].bounds.size.height - lableSize.height - FontSize(10)) / 2, w+ FontSize(10) , lb.frame.size.height + FontSize(10 )+ HiddenImageH);
    
    iv.centerX = (w / 2);
    [UIView animateWithDuration:time animations:^{
        showView.alpha = 0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];

}
@end
