//
//  WCYWaveProgressView.h
//  12333
//
//  Created by 汇元 on 2018/6/1.
//  Copyright © 2018年 汇元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCYWaveProgressView : UIView
/**
 进度 0-1
 */
@property (nonatomic,assign) CGFloat progress;

/**
 波动速度，默认 1
 */
@property (nonatomic,assign) CGFloat speed;

/**
 波动幅度，默认 5
 */
@property (nonatomic,assign) CGFloat waveHeight;

/**
 一句话生成波浪效果
 由于一般进度显示都是获取进度在显示对应进度 progress未加入设置  需要手动设置
 
 @param frame 坐标
 @param backgroundImageName 背景图片
 @param waveImageArray 波浪数组 一张的只显示一个波浪  两个显示双重波浪  一般两个波浪足够
 @param speed 波动速度  可以不填 不填默认为1
 @param waveHeight 波动幅度 可以不填 不填默认为5
 */
- (instancetype)initWithFrame:(CGRect)frame backgroundImageName:(NSString *)backgroundImageName waveImageNameArray:(NSArray *)waveImageArray speed:(CGFloat)speed waveHeight:(CGFloat)waveHeight;

/**
 开始波浪动画
 */
- (void)startWaveAnimation;

/**
 停止波浪动画
 */
- (void)stopWaveAnimation;

@end
