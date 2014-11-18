//
//  ViewController.m
//  等待下一次验证码
//
//  Created by luozhijun on 14-11-18.
//  Copyright (c) 2014年 bgyun. All rights reserved.
//

#define kMaxTimeInterval 5

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *authCodeBtn;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, assign) NSInteger maxTimeInterval;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maxTimeInterval = kMaxTimeInterval;
}


- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countSecond) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)countSecond
{
    self.maxTimeInterval -- ;
    [self.authCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获取", self.maxTimeInterval] forState:UIControlStateDisabled];
    if (self.maxTimeInterval == 0) {
        self.authCodeBtn.enabled = YES;
        [self removeTimer];
        self.maxTimeInterval = kMaxTimeInterval;
        [self.authCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.authCodeBtn.backgroundColor = [UIColor blueColor];
    }
}

- (IBAction)buttonClick:(UIButton *)sender {
    sender.enabled = !sender.isEnabled;
    if (!sender.enabled) {
        [sender setTitle:[NSString stringWithFormat:@"%d秒后重新获取", kMaxTimeInterval] forState:UIControlStateDisabled];
        sender.backgroundColor = [UIColor lightGrayColor];
        [self addTimer];
    }
}

@end
