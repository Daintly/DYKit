//
//  WEmitterButton.m
//  WEmitterButton
//
//  Created by 王王亚 on 16/12/1.
//  Copyright © 2016年 王亚. All rights reserved.
//

#import "WEmitterButton.h"

@interface WEmitterButton ()

/** weak类型 粒子发射器图层 */
@property (nonatomic, weak)  CAEmitterLayer *emitterLayer;

@property (nonatomic, assign) WButtonType type;

@property (nonatomic, assign) CGFloat spacing;


@end

@implementation WEmitterButton

/**
 *  初始化方法
 *
 *  @param type 类型
 *
 *  @return 实例对象
 */
- (instancetype)initWithType:(WButtonType)type spacing:(CGFloat)spacing{
    
    if (self = [super init]) {
        _type = type;
        _spacing = spacing;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self animation];
}

/**
 *  重写selected 方法
 *
 *  @param selected 系统参数
 */
- (void)setHighlighted:(BOOL)highlighted{

}


- (void)setup {

    CAEmitterCell *emitterCell   = [CAEmitterCell emitterCell];
    emitterCell.name             = @"emitterCell";
    emitterCell.alphaRange       = 0.10;
    emitterCell.alphaSpeed       = -1.0;
    emitterCell.lifetime         = 0.7;
    emitterCell.lifetimeRange    = 0.3;
    emitterCell.velocity         = 30.00;
    emitterCell.velocityRange    = 4.00;
    emitterCell.scale            = 0.1;
    emitterCell.scaleRange       = 0.02;
    emitterCell.contents         = (id)[UIImage imageNamed:@"Sparkle3"].CGImage;
    
    
    CAEmitterCell *emitterCell3  = [CAEmitterCell emitterCell];
    emitterCell3.name            = @"emitterCell3";
    emitterCell3.alphaRange      = 0.10;
    emitterCell3.alphaSpeed      = -1.0;
    emitterCell3.lifetime        = 0.7;
    emitterCell3.lifetimeRange   = 0.3;
    emitterCell3.velocity        = 30.00;
    emitterCell3.velocityRange   = 4.00;
    emitterCell3.scale           = 0.1;
    emitterCell3.scaleRange      = 0.02;
    emitterCell3.contents        = (id)[UIImage imageNamed:@"Sparkle1"].CGImage;
    

    CAEmitterLayer *layer        = [CAEmitterLayer layer];
    layer.name                   = @"emitterLayer";
    layer.emitterShape           = kCAEmitterLayerCircle;
    layer.emitterMode            = kCAEmitterLayerOutline;
    layer.emitterCells           = @[emitterCell, emitterCell3];
    layer.renderMode             = kCAEmitterLayerOldestFirst;
    layer.masksToBounds          = NO;
    layer.zPosition              = -1;
    
    [self.layer addSublayer:layer];
    _emitterLayer = layer;
}


/**
 *  点赞效果动画
 */
- (void)animation {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (self.selected) {
        animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
        animation.duration = 0.5;
        // 粒子发射器 发射
        [self startFire];
    }else
    {
        animation.values = @[@0.8, @1.0];
        animation.duration = 0.4;
    }
    animation.calculationMode = kCAAnimationCubic;
    [self.imageView.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)startFire{
    
    // 每秒喷射的80个
    [self.emitterLayer setValue:@1000 forKeyPath:@"emitterCells.emitterCell.birthRate"];
    [self.emitterLayer setValue:@1000 forKeyPath:@"emitterCells.emitterCell3.birthRate"];
    // 开始
    self.emitterLayer.beginTime = CACurrentMediaTime();
    // 执行停止
    [self performSelector:@selector(stopFire) withObject:nil afterDelay:0.1];
   
}

- (void)stopFire {
    
    //每秒喷射的个数0个
    [self.emitterLayer setValue:@0 forKeyPath:@"emitterCells.emitterCell.birthRate"];
    [self.emitterLayer setValue:@0 forKeyPath:@"emitterCells.emitterCell3.birthRate"];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    switch (_type) {
            
        case WButtonTypeImageDown:
            
            self.titleLabel.centerX = CGRectGetMidX(self.bounds);
            self.titleLabel.y = 0;
            
            self.imageView.centerX = CGRectGetMidX(self.bounds);
            self.imageView.y = CGRectGetMaxY(self.titleLabel.frame) + _spacing;
            
            
            break;
            
            case WButtonTypeImageUp:
            
            self.imageView.centerX = CGRectGetMidX(self.bounds);
            self.imageView.y = 0;
            
            self.titleLabel.centerX = CGRectGetMidX(self.bounds);
            self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + _spacing;

            break;
            
        default:
            break;
    }
    
    /// 设置粒子发射器的锚点
    _emitterLayer.position = self.imageView.center;
    
    
}


@end
