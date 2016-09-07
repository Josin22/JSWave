# JSWave
[![GitHub license](https://img.shields.io/badge/platform-ios-green.svg
)](https://github.com/josin22/JSWave)
[![GitHub license](https://img.shields.io/badge/license-MIT-green.svg)](https://raw.githubusercontent.com/josin22/JSWave/master/LICENSE)
[![CocoaPods Compatible](https://img.shields.io/badge/build-passing-green.svg)](https://github.com/josin22/JSWave)


# 安装
支持pod 安装

	pod 'JSWave'
	

# 效果演示

![images](https://raw.githubusercontent.com/Josin22/JSWave/master/Images/jswave.gif)


# 你需要知道的

## CADisplayLink
简单的说就是一定时器,其根本利用刷帧和屏幕频率一样来重绘渲染页面.
其创建方式:
    
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
## CAShapeLayer
CALayer的子类,通常结合CGPath来绘制图形.
其创建方式:
	
	CAShapeLayer *Layer = [CAShapeLayer layer];
	Layer.frame =  self.bounds;
    Layer.fillColor = self.realWaveColor.CGColor;
    Layer...等属性
    [self.view.layer addSublayer:Layer];

其优点    

* 渲染效率高渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
* 高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
* 不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉。
* 不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。


## 三角函数

![images](https://raw.githubusercontent.com/Josin22/JSWave/master/Images/sinf.png)

![images](https://raw.githubusercontent.com/Josin22/JSWave/master/Images/cosf.png)



# 思路实现

UIView --> 2个CAShapeLayer --> imageView.frame.orgin.y调整

# 主要代码实现
## 头文件

![images](https://raw.githubusercontent.com/Josin22/JSWave/master/Images/code_wave_h.png)

##  实现

![images](https://raw.githubusercontent.com/Josin22/JSWave/master/Images/code_wave.png)

## 调用
![images](https://raw.githubusercontent.com/Josin22/JSWave/master/Images/wave_uses.png)





更多详细请移步[我的博客](http://qiaotongxin.cc/2016/08/22/20160822/#more)

更多详细请移步[我的博客](http://qiaotongxin.cc/2016/08/22/20160822/#more)

更多详细请移步[我的博客](http://qiaotongxin.cc/2016/08/22/20160822/#more)