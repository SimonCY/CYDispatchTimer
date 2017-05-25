# CYDispatchTimer

  CYDispatchTimer是基于GCD封装的weakTimer，使用效果与NSTimer类似，但是更简单、安全，不会引发对taget强引用而造成的内存泄漏，基于nameMap进行管理、block处理触发方法，使用更高效。
  
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/AAChartModel/AAChartKit/blob/master/AAChartKit/ChartsDemo/LICENSE)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

-----------------------------------------------------

## Usage


### 1.开启定时器
```objc
if (![CYDispatchTimer isTimerExistWithName:CameraTimeViewTimerName]) {
 
    [CYDispatchTimer scheduledDispatchTimerInGlobalQueueWithName:CameraTimeViewTimerName timeInterval:1 repeats:YES action:^{
        
    //code here...
    
  }];
}
```
    
### 2.停止定时器
  
```objc
if ([CYDispatchTimer isTimerExistWithName:CameraTimeViewTimerName]) {
  
    [CYDispatchTimer cancelTimerWithName:CameraTimeViewTimerName];
}
```

## Implementation

内部由GCD实现，可选择在主队列或者全局队列中执行触发方法，没有NSTimer那种对target的引用
```objc
+ (void)scheduledDispatchTimerWithName:(NSString *)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action {
    
    if (timerName == nil) return;
    
    if (queue == nil) {
        
        queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    
    dispatch_source_t timer = [self timerWithName:timerName];
    if (timer) {
        NSLog(@"the timer named %@ is exist",timerName);
        return;
    } else {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        [self timerContainer][timerName] = timer;
    }
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL,0), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        action();
        
        if (!repeats) {
            [weakSelf cancelTimerWithName:timerName];
        }
    });
    dispatch_resume(timer);
}
```

## <a id="Hope"></a>Hope
* If you find bug when used，Hope you can Issues me，Thank you or try to download the latest code of this framework to see the BUG has been fixed or not）
* If you find the function is not enough when used，Hope you can Issues me，I very much to add more useful function to this framework ，Thank you !
* 如果使用过程中发现任何问题，欢迎issue我，我会尽快解决。
* 如果在需求上有任何的意见或者建议，也欢迎issue提出，非常感谢！
## Contact to me
* QQ:397604080  
 
## License

The MIT License (MIT) - see [LICENSE](LICENSE) file.
