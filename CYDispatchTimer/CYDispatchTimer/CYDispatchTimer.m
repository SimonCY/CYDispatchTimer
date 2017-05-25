//
//  CYTimer.m
//  zhiying
//
//  Created by DeepAI on 2017/5/22.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYDispatchTimer.h"

static NSMutableDictionary *_timerContainer;

@implementation CYDispatchTimer

#pragma mark - public
+ (BOOL)isTimerExistWithName:(NSString *)timerName {
    
    dispatch_source_t timer = [self timerWithName:timerName];
    if (timer) {
        return YES;
    } else {
        return NO;
    }
}

+ (dispatch_source_t)timerWithName:(NSString *)timerName {
    
    dispatch_source_t timer = [self timerContainer][timerName];
    if (timer) {
        return timer;
    } else {
        return nil;
    }
}

+ (void)scheduledDispatchTimerInMainQueueWithName:(NSString *)timerName timeInterval:(double)interval  repeats:(BOOL)repeats action:(dispatch_block_t)action {
    
    [self scheduledDispatchTimerWithName:timerName timeInterval:interval queue:dispatch_get_main_queue() repeats:repeats action:action];
}

+ (void)scheduledDispatchTimerInGlobalQueueWithName:(NSString *)timerName timeInterval:(double)interval  repeats:(BOOL)repeats action:(dispatch_block_t)action {
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self scheduledDispatchTimerWithName:timerName timeInterval:interval queue:globalQueue repeats:repeats action:action];
}

+ (void)scheduledDispatchTimerWithName:(NSString *)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action {
    
    if (timerName == nil) return;
    
    if (queue == nil) {
        
        queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    
    dispatch_source_t timer = [self timerWithName:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
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
}

+ (void)cancelTimerWithName:(NSString *)timerName {
    
    if ([self isTimerExistWithName:timerName]) {
        
        dispatch_source_cancel([self timerWithName:timerName]);
        [[self timerContainer] removeObjectForKey:timerName];
    }
}


#pragma mark - pravite

#pragma mark - getter

+ (NSMutableDictionary *)timerContainer {
    
    if (_timerContainer == nil) {
        _timerContainer = [NSMutableDictionary dictionary];
    }
    return _timerContainer;
}
@end
