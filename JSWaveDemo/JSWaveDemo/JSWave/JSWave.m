//
//  JSWave.m
//  JSWaveDemo
//
//  Created by 乔同新 on 16/8/20.
//  Copyright © 2016年 乔同新. All rights reserved.
//  Github  Demo  ::  https://github.com/Josin22/JSWave/

#import "JSWave.h"

@interface JSWave ()
//刷屏器
@property (nonatomic, strong) CADisplayLink *timer;
//真实浪
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;
//遮罩浪
@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;

@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation JSWave

- (void)awakeFromNib{
    
    [self initData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData{
    //初始化
    self.waveSpeed = 0.7;
    self.waveCurvature = 2.0;
    self.waveHeight = 5;
    self.realWaveColor = [UIColor whiteColor];
    self.maskWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    
    [self.layer addSublayer:self.realWaveLayer];
    [self.layer addSublayer:self.maskWaveLayer];
    
    [self addSubview:self.iconImageView];
    
    [self startWaveAnimation];
}

- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-30, 0, 60, 60)];
        _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconImageView.layer.borderWidth = 2;
        _iconImageView.layer.cornerRadius = 20;
    }
    return _iconImageView;
}


- (CAShapeLayer *)realWaveLayer{
    
    if (!_realWaveLayer) {
        _realWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y = frame.size.height-self.waveHeight;
        frame.size.height = self.waveHeight;
        _realWaveLayer.frame = frame;
        _realWaveLayer.fillColor = self.realWaveColor.CGColor;
        
    }
    return _realWaveLayer;
}

- (CAShapeLayer *)maskWaveLayer{
    
    if (!_maskWaveLayer) {
        _maskWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y = frame.size.height-self.waveHeight;
        frame.size.height = self.waveHeight;
        _maskWaveLayer.frame = frame;
        _maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    }
    return _maskWaveLayer;
}

- (void)startWaveAnimation{
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)stopWaveAnimation{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)wave{
    
    self.offset += self.waveSpeed;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(_realWaveLayer.frame);
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    CGFloat iconHeight = CGRectGetHeight(_iconImageView.frame);
    
    //真实浪
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height );
    CGFloat y = 0.f;
    for (CGFloat x = 0.f; x <= width ; x++) {
        y = height * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    CGFloat centX = self.bounds.size.width/2;
    CGFloat CentY = height * sinf(0.01 * self.waveCurvature *centX  + self.offset * 0.045);
    CGRect iconFrame = [self.iconImageView frame];
    iconFrame.origin.y = selfHeight-iconHeight+CentY-height;
    self.iconImageView.frame  =iconFrame;
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.realWaveLayer.path = path;
    self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
    CGPathRelease(path);
    //遮罩浪
    CGMutablePathRef maskpath = CGPathCreateMutable();
    CGPathMoveToPoint(maskpath, NULL, 0, height);
    CGFloat maskY = 0.f;
    for (CGFloat x = 0.f; x <= width ; x++) {
        maskY = height * cosf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(maskpath, NULL, x, maskY);
    }
    CGPathAddLineToPoint(maskpath, NULL, width, height);
    CGPathAddLineToPoint(maskpath, NULL, 0, height);
    CGPathCloseSubpath(maskpath);
    self.maskWaveLayer.path = maskpath;
    self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    CGPathRelease(maskpath);
    
}

- (void)dealloc{
    
    [self stopWaveAnimation];
    
    if (_realWaveLayer) {
        [_realWaveLayer removeFromSuperlayer];
        _realWaveLayer = nil;
    }
    
    if (_maskWaveLayer) {
        [_maskWaveLayer removeFromSuperlayer];
        _maskWaveLayer = nil;
    }
}

@end
