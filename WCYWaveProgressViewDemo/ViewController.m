//
//  ViewController.m
//  WCYWaveProgressViewDemo
//
//  Created by wcy on 2018/8/28.
//  Copyright © 2018年 wcy. All rights reserved.
//

#import "ViewController.h"

#import "WCYWaveProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) WCYWaveProgressView *waveProgressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.waveProgressView = [[WCYWaveProgressView alloc] initWithFrame:CGRectMake(100, 100, 38, 35) backgroundImageName:@"investList_wave_background" waveImageNameArray:@[@"investList_wave_two",@"investList_wave"] speed:1.5 waveHeight:3];
    
    self.waveProgressView.progress = 0.5;
    
    [self.view addSubview:self.waveProgressView];
    
//     // 一个延时操作 停止波浪动画和开始波浪动画
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.waveProgressView stopWaveAnimation];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.waveProgressView startWaveAnimation];
//        });
//    });
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
