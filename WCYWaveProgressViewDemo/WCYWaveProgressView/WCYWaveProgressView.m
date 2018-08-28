//
//  WCYWaveProgressView.m
//  12333
//
//  Created by 汇元 on 2018/6/1.
//  Copyright © 2018年 汇元. All rights reserved.
//

#import "WCYWaveProgressView.h"

@interface WCYWaveProgressView ()
@property (nonatomic, strong) NSArray *waveArray;

@property (nonatomic, assign) CGFloat yHeight;

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) CADisplayLink * timer;
@property (nonatomic, strong) CAShapeLayer * firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer * secondWaveLayer;

@property (nonatomic, strong) UIImageView *grayImageView;
@property (nonatomic, strong) UIImageView *sineImageView;
@property (nonatomic, strong) UIImageView *cosineImageView;

@end

@implementation WCYWaveProgressView

- (instancetype)initWithFrame:(CGRect)frame backgroundImageName:(NSString *)backgroundImageName waveImageNameArray:(NSArray *)waveImageArray speed:(CGFloat)speed waveHeight:(CGFloat)waveHeight {
    if (self = [super initWithFrame:frame]) {
        self.bounds = CGRectMake(0, 0, MIN(frame.size.width, frame.size.height), MIN(frame.size.width, frame.size.height));
        
        self.waveArray = waveImageArray;
        
        // 背景  进度0
        self.grayImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.grayImageView.image = [UIImage imageNamed:backgroundImageName];
        [self addSubview:self.grayImageView];
        
        // 基本默认参数
        self.yHeight = self.bounds.size.height;
        
        if (self.waveHeight != 0) {
            self.waveHeight = waveHeight;
        } else {
             self.waveHeight = 5.0;
        }
        
        if (self.speed != 0) {
            self.speed = speed;
        } else {
            self.speed = 1.0;
        }
        
        if (waveImageArray.count != 0) {
            
            // 波浪 图片1
            self.sineImageView = [[UIImageView alloc] initWithFrame:self.bounds];
            self.sineImageView.image = [UIImage imageNamed:waveImageArray[0]];
            [self addSubview:self.sineImageView];
            
            // 设置第一张波浪图  波动
            [self.layer addSublayer:self.firstWaveLayer];
            self.sineImageView.layer.mask = _firstWaveLayer;
            
            if (waveImageArray.count > 1) {
                // 波浪 图片2
                
                self.cosineImageView = [[UIImageView alloc] initWithFrame:self.bounds];
                self.cosineImageView.image = [UIImage imageNamed:waveImageArray[1]];
                [self addSubview:self.cosineImageView];
                
                [self.layer addSublayer:self.secondWaveLayer];
                self.cosineImageView.layer.mask = _secondWaveLayer;
            }
        }
    }
    return self;
}

#pragma mark -- 设置进度
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.yHeight = self.bounds.size.height * (1 - progress);
    
    [self stopWaveAnimation];
    [self startWaveAnimation];
}

#pragma mark -- 开始波动动画
- (void)startWaveAnimation {
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


#pragma mark -- 停止波动动画
- (void)stopWaveAnimation {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -- 波动动画实现
- (void)waveAnimation {
    CGFloat waveHeight = self.waveHeight;
    if (self.progress == 0.0f || self.progress == 1.0f) {
        waveHeight = 0.f;
    }
    
    self.offset += self.speed;
    //第一个波纹
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGFloat startOffY = waveHeight * sinf(self.offset * M_PI * 2 / self.bounds.size.width);
    CGFloat orignOffY = 0.0;
    CGPathMoveToPoint(pathRef, NULL, 0, startOffY);
    for (CGFloat i = 0.f; i <= self.bounds.size.width; i++) {
        orignOffY = waveHeight * sinf(2 * M_PI / self.bounds.size.width * i + self.offset * M_PI * 2 / self.bounds.size.width) + self.yHeight;
        CGPathAddLineToPoint(pathRef, NULL, i, orignOffY);
    }
    
    CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, orignOffY);
    CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, self.bounds.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, self.bounds.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, startOffY);
    CGPathCloseSubpath(pathRef);
    self.firstWaveLayer.path = pathRef;
    CGPathRelease(pathRef);
    
    if (self.waveArray.count > 1) {
        //第二个波纹
        CGMutablePathRef pathRef1 = CGPathCreateMutable();
        CGFloat startOffY1 = waveHeight * sinf(self.offset * M_PI * 2 / self.bounds.size.width);
        CGFloat orignOffY1 = 0.0;
        CGPathMoveToPoint(pathRef1, NULL, 0, startOffY1);
        for (CGFloat i = 0.f; i <= self.bounds.size.width; i++) {
            orignOffY1 = waveHeight * cosf(2 * M_PI / self.bounds.size.width * i + self.offset * M_PI * 2 / self.bounds.size.width) + self.yHeight;
            CGPathAddLineToPoint(pathRef1, NULL, i, orignOffY1);
        }
        
        CGPathAddLineToPoint(pathRef1, NULL, self.bounds.size.width, orignOffY1);
        CGPathAddLineToPoint(pathRef1, NULL, self.bounds.size.width, self.bounds.size.height);
        CGPathAddLineToPoint(pathRef1, NULL, 0, self.bounds.size.height);
        CGPathAddLineToPoint(pathRef1, NULL, 0, startOffY1);
        CGPathCloseSubpath(pathRef1);
        self.secondWaveLayer.path = pathRef1;
        
        CGPathRelease(pathRef1);
    }
    
}

#pragma mark ----- INITUI ----
- (CAShapeLayer *)firstWaveLayer{
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.frame = self.bounds;
    }
    return _firstWaveLayer;
}

- (CAShapeLayer *)secondWaveLayer{
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.frame = self.bounds;
    }
    return _secondWaveLayer;
}

- (void)dealloc{
    
    [self.timer invalidate];
    self.timer = nil;
    
    if (_firstWaveLayer) {
        [_firstWaveLayer removeFromSuperlayer];
        _firstWaveLayer = nil;
    }
    
    if (_secondWaveLayer) {
        [_secondWaveLayer removeFromSuperlayer];
        _secondWaveLayer = nil;
    }
}


@end

