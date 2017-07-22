//
//  JSWave.m
//  JSWaveDemo
//
//  Created by 乔同新 on 16/8/20.
//  Copyright © 2016年 乔同新. All rights reserved.
//  Github  Demo  ::  https://github.com/Josin22/JSWave/

#import "JSWave.h"

@interface JSProxy : NSObject
@property (weak, nonatomic) id executor;
@end

@implementation JSProxy

-(void)callback {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    [_executor performSelector:@selector(wave)];
    
#pragma clang diagnostic pop
}

@end

@interface JSWave ()
//刷屏器
@property (nonatomic, strong) CADisplayLink *timer;
//真实浪
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;
//遮罩浪
@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;

@property (nonatomic, assign) CGFloat offset;

@end

@implementation JSWave

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
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
    self.waveSpeed = 0.5;
    self.waveCurvature = 1.5;
    self.waveHeight = 4;
    self.realWaveColor = [UIColor whiteColor];
    self.maskWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    
    [self.layer addSublayer:self.realWaveLayer];
    [self.layer addSublayer:self.maskWaveLayer];
    
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

- (void)setWaveHeight:(CGFloat)waveHeight{
    _waveHeight = waveHeight;
    
    CGRect frame = [self bounds];
    frame.origin.y = frame.size.height-self.waveHeight;
    frame.size.height = self.waveHeight;
    _realWaveLayer.frame = frame;
    
    CGRect frame1 = [self bounds];
    frame1.origin.y = frame1.size.height-self.waveHeight;
    frame1.size.height = self.waveHeight;
    _maskWaveLayer.frame = frame1;
    
}

- (void)startWaveAnimation{
    JSProxy *proxy = [[JSProxy alloc] init];
    proxy.executor = self;
    self.timer = [CADisplayLink displayLinkWithTarget:proxy selector:@selector(callback)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)stopWaveAnimation{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)wave{
    
    self.offset += self.waveSpeed;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = self.waveHeight;
    
    //path1
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, NULL, 0, height);
    CGFloat path1y = 0.f;
    //path2
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, 0, height);
    CGFloat path2Y = 0.f;
    
    for (CGFloat x = 0.f; x <= width ; x++) {
        path1y = height * sinf([self getSinfWithPercent:5.0f widthX:x]);
        CGPathAddLineToPoint(path1, NULL, x, path1y);
        
        path2Y = height * sinf([self getSinfWithPercent:3.2f widthX:x]);
        CGPathAddLineToPoint(path2, NULL, x, path2Y);
        
    }
    //变化的中间Y值
    CGFloat centX = self.bounds.size.width/2;
    CGFloat CentY = height * sinf([self getSinfWithPercent:5.0f widthX:centX]);
    if (self.waveBlock) {
        self.waveBlock(CentY);
    }
    
    CGPathAddLineToPoint(path1, NULL, width, height);
    CGPathAddLineToPoint(path1, NULL, 0, height);
    CGPathCloseSubpath(path1);
    self.realWaveLayer.path = path1;
    self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
    CGPathRelease(path1);
    
    CGPathAddLineToPoint(path2, NULL, width, height);
    CGPathAddLineToPoint(path2, NULL, 0, height);
    CGPathCloseSubpath(path2);
    self.maskWaveLayer.path = path2;
    self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    CGPathRelease(path2);
    
}

- (float)getSinfWithPercent:(float)percent widthX:(CGFloat)widthX{
    return (self.waveCurvature * widthX + self.offset * percent)/100;
}

@end
