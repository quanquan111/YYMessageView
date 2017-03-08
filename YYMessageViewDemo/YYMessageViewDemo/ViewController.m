//
//  ViewController.m
//  YYMessageViewDemo
//
//  Created by shifangyuan on 2017/3/8.
//  Copyright © 2017年 石方圆. All rights reserved.
//

#import "ViewController.h"

#import "UIView+YYMessageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)setType:(NSInteger)type
{
    switch (type) {
        case 1: {
            [self.view showMessageNotData];
        }
            break;
        case 2: {
            [self.view showMessageByImageNamed:@"msg_wait"
                                         title:@"暂时没有数据"
                                        detail:@"请等待片刻在进行查看"];
        }
            break;
        case 3:{
            __weak typeof(self) weakSelf = self;
            [self.view showMessageNotNetwork:^{
                [weakSelf csAction];
            }];
        }
            break;
            
        default:
            break;
    }
}

-(void)csAction
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"start do something");
    [self.view hiddenMessageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.view showMessageNotData];
        NSLog(@"end do something");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
