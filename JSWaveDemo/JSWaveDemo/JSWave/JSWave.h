//
//  JSWave.h
//  JSWaveDemo
//
//  Created by 乔同新 on 16/8/20.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSWave : UIView
/**
 *  角速
 */
@property (nonatomic, assign) CGFloat waveSpeed;
/**
 *  浪速
 */
@property (nonatomic, assign) CGFloat speed;
/**
 *  浪高
 */
@property (nonatomic, assign) CGFloat waveHeight;
/**
 *  实浪颜色
 */
@property (nonatomic, strong) UIColor *realWaveColor;
/**
 *  遮罩浪颜色
 */
@property (nonatomic, strong) UIColor *maskWaveColor;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;

@end
