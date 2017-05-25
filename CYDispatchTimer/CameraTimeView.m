//
//  CameraTimeView.m
//  zhiying
//
//  Created by DeepAI on 2017/5/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CameraTimeView.h"
#import "CYDispatchTimer.h"

@interface CameraTimeView ()
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *redPoint;

@end

#define CameraTimeViewTimerName  @"CameraTimeViewTimerName"
@implementation CameraTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.redPoint = [[UIView alloc] init];
        self.redPoint.backgroundColor = [UIColor redColor];
        [self addSubview:self.redPoint];

        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.text = @"00:00:00";
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeLabel];
        
        _totalSecond = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    
    CGFloat timeH = self.bounds.size.height;
    CGFloat timeW = 66;
    CGFloat timeY = 0;
    CGFloat timeX = self.bounds.size.width / 2 - timeW / 2;
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat redWH = 10;
    CGFloat redY = (self.bounds.size.height - redWH) / 2;
    CGFloat redX = CGRectGetMinX(self.timeLabel.frame) - redWH - redY;
    self.redPoint.frame = CGRectMake(redX, redY, redWH, redWH);
    self.redPoint.layer.cornerRadius = redWH / 2;
    
}

#pragma mark - public
- (void)reset {
    [self stop];
    
    self.timeLabel.text = @"00:00:00";
    _totalSecond = 0;
}

- (void)start {
    [self startTimer];
}

- (void)stop {
    [self stopTimer];
}

#pragma mark - timer
- (void)startTimer {
    if ([CYDispatchTimer isTimerExistWithName:CameraTimeViewTimerName]) return;
    
    [CYDispatchTimer scheduledDispatchTimerInGlobalQueueWithName:CameraTimeViewTimerName timeInterval:1 repeats:YES action:^{
        
        int seconds = _totalSecond % 60;
        int minutes = _totalSecond / 60 % 60;
        int hours = _totalSecond / 60 / 60;
        NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置
            NSLog(@"____%@",timeStr);
            CGFloat redAlpha = _totalSecond%2?0:1;
            [UIView animateWithDuration:0.4 animations:^{
                _redPoint.alpha = redAlpha;
            }];
            _timeLabel.text = [timeStr copy];
            _totalSecond++;
            
        });
    }];
}

- (void)stopTimer {
    if (![CYDispatchTimer isTimerExistWithName:CameraTimeViewTimerName]) return;
        
    [CYDispatchTimer cancelTimerWithName:CameraTimeViewTimerName];
    [UIView animateWithDuration:0.4 animations:^{
        
        self.redPoint.alpha = 1;
    }];
}


@end
