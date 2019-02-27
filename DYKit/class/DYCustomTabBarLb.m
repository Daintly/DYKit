//
//  DYCustomTabBarLb.m
//  uuyu
//
//  Created by Dainty on 2019/2/27.
//  Copyright © 2019年 DAINTY. All rights reserved.
//
#define kLbWidth self.bounds.size.width
#define kLbHeight self.bounds.size.height
#import "DYCustomTabBarLb.h"
@interface DYCustomTabBarLb ()

@property(nonatomic, strong) NSString *tabBarIndex;
@end
@implementation DYCustomTabBarLb


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
              [self setUp];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setTabBarIndexStr:)
                                                     name:@"NotifyTabBarIndex"
                                                   object:nil];
        self.tabBarIndex = 0;
    }return self;
}

- (NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i = 1; i < 9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [_images addObject:image];
        }
        
    }return _images;
}



- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [self.backgroundColor CGColor];
        [self.superview.layer insertSublayer:_shapeLayer above:self.layer];
        
        
    }return _shapeLayer;
}


- (UIView *)samllCircleView{
    if (!_samllCircleView) {
        _samllCircleView = [UIView new];
        _samllCircleView.backgroundColor = self.backgroundColor;
        
        
        [self.superview insertSubview:_samllCircleView belowSubview:self];
        
    }return _samllCircleView;
}

- (void)setUp{
    CGFloat cornerRadius = (kLbHeight > kLbWidth ? kLbWidth / 2.0 : kLbHeight / 2.0);
    self.backgroundColor = [UIColor redColor];
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont boldSystemFontOfSize:9];
    self.textAlignment = NSTextAlignmentCenter;
    _maxDistance = cornerRadius * 5;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    CGRect smallCireleRect = CGRectMake(0, 0, cornerRadius * (2 - 0.5), cornerRadius * (2 - - 0.5));
    self.samllCircleView.bounds = smallCireleRect;
    _samllCircleView.center = self.center;
    _samllCircleView.layer.cornerRadius = _samllCircleView.bounds.size.width / 2;
}

- (void)setTabBarIndexStr:(NSNotification *)notify {
    if (notify != nil) {
        self.tabBarIndex = notify.object;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
