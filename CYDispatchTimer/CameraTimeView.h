//
//  CameraTimeView.h
//  zhiying
//
//  Created by DeepAI on 2017/5/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CameraTimeView : UIView

@property (nonatomic,assign,readonly) int totalSecond;

- (void)reset;

- (void)start;
//销毁之前  应该调用一次stop  不然timeView可能不会被正常释放
- (void)stop;
@end
