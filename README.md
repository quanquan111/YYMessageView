# YYMessageView
一个Object-C封装的简单通用提示视图

#pods使用方法
pod 'YYMessageView'

#直接导入
直接导入YYMessageView文件夹到项目

#使用方法

导入头文件
#import "UIView+YYMessageView.h"

任意View子类

展示默认视图
[view showMessageNotData];

自定义展示视图 (无操作按钮)
[view showMessageByImageNamed:@"imageNamed"
                        title:@"title"
                       detail:@"detail"];
                       
自定义展示视图 (带操作按钮)
__weak typeof(self) weakSelf = self;
[view showMessageByImageNamed:@"data_not"
                        title:@"暂时没有数据"
                       detail:@"请等待片刻再进行查看"
                    operation:@"返回"
                        block:^{
                              //do something ..
                        }];
                             
网络异常默认处理
 __weak typeof(self) weakSelf = self;
[view showMessageNotNetwork:^{
      [weakSelf requestData];
}];

-(void)requestData
{
    [view hiddenMessageView];
    
    //此处模拟网络请求成功 并且 没有获取到数据的情况
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view showMessageNotData];
    });
}


