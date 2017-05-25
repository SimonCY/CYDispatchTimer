//
//  ViewController.m
//  CYDispatchTimer
//
//  Created by DeepAI on 2017/5/25.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "ViewController.h"
#import "CameraTimeView.h"
#import "iPhoneMacro.h"

@interface ViewController ()
@property (nonatomic,strong) CameraTimeView *timeView;
@property (nonatomic,strong) UIButton *startbtn;
@property (nonatomic,strong) UIButton *resetbtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //timeView
    self.timeView = [[CameraTimeView alloc] init];
    self.timeView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.timeView.frame = CGRectMake(0, 100, cy_SCREEN_WIDTH, 40);
    [self.view addSubview:self.timeView];
    
    //startbtn
    self.startbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.startbtn.backgroundColor = [UIColor yellowColor];
    self.startbtn.frame = CGRectMake(50, 300, cy_SCREEN_WIDTH - 100, 50);
    self.startbtn.layer.cornerRadius = 5;
    self.startbtn.clipsToBounds = YES;
    [self.startbtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.startbtn setTitle:@"Stop" forState:UIControlStateSelected];
    [self.view addSubview: self.startbtn];
    [self.startbtn addTarget:self action:@selector(startBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    
    //resetbtn
    self.resetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.resetbtn.backgroundColor = [UIColor orangeColor];
    self.resetbtn.frame = CGRectMake(50, 400, cy_SCREEN_WIDTH - 100, 50);
    self.resetbtn.layer.cornerRadius = 5;
    self.resetbtn.clipsToBounds = YES;
    [self.resetbtn setTitle:@"Reset" forState:UIControlStateNormal];
    [self.view addSubview: self.resetbtn];
    [self.resetbtn addTarget:self action:@selector(resetBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark - btnEvent
- (void)startBtnEvent {
    self.startbtn.selected = !self.startbtn.isSelected;
    if (self.startbtn.isSelected) {
    
        [self.timeView start];
    } else {
    
        [self.timeView stop];
    }
}

- (void)resetBtnEvent {
    self.startbtn.selected = NO;
    [self.timeView reset];
}

@end
