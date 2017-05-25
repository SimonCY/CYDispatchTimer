//
//  CYTimer.h
//  zhiying
//
//  Created by DeepAI on 2017/5/22.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `CYDidpatchTimer` works similar to an `NSTimer` but easier and doesn't retain the target.
 This timer is implemented using GCD, so you can schedule and unschedule it on arbitrary queues (unlike regular NSTimers!)
 */
@interface CYDispatchTimer : NSObject

+ (BOOL)isTimerExistWithName:(NSString *)timerName;

+ (dispatch_source_t)timerWithName:(NSString *)timerName;



+ (void)scheduledDispatchTimerInMainQueueWithName:(NSString *)timerName
                                     timeInterval:(double)interval
                                          repeats:(BOOL)repeats
                                           action:(dispatch_block_t)action;

+ (void)scheduledDispatchTimerInGlobalQueueWithName:(NSString *)timerName
                                       timeInterval:(double)interval
                                            repeats:(BOOL)repeats
                                             action:(dispatch_block_t)action;

+ (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                                action:(dispatch_block_t)action;


+ (void)cancelTimerWithName:(NSString *)timerName;
@end
