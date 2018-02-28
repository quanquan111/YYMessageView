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
            [self.view showMessageByImageNamed:@"data_not"
                                         title:@"暂时没有数据"
                                        detail:@"请等待片刻再进行查看"];
        }
            break;
        case 3:{
            __weak typeof(self) weakSelf = self; 
            [self.view showMessageByImageNamed:@"data_not"
                                         title:@"暂时没有数据"
                                        detail:@"请等待片刻再进行查看"
                                     operation:@"返 回"
                                         block:^{
                                             [weakSelf.navigationController popViewControllerAnimated:YES];
                                         }];
        }
            break;
        case 4:{
            __weak typeof(self) weakSelf = self;
            [self.view showMessageNotNetwork:^{
                [weakSelf requestData];
            }];
        }
            break;
            
        default:
            break;
    }
}

-(void)requestData
{
    __weak typeof(self) weakSelf = self;
    [self.view hiddenMessageView];
    //此处模拟网络请求 并且 请求出来的结果是没有数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.view showMessageNotData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
