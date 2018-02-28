//
//  UIView+YYMessageView.h
//  Demo_Message
//
//  Created by shifangyuan on 2017/3/6.
//  Copyright © 2017年 石方圆. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 操作按钮点击 回调block
 */
typedef void(^OperationBlock)(void);

@interface UIView (YYMessageView)

/**
 默认显示 无数据视图
 */
-(void)showMessageNotData;

/**
 默认显示 无网络视图

 @param block 无网络连接时 操作按钮点击回调block
 */
-(void)showMessageNotNetwork:(OperationBlock)block;

/**
 自定义数据展示方法 默认是没有操作按钮的
 
 @param imageNamed 需展示的图片名字
 @param title 提示文字
 @param detail 详细文字
 */
-(void)showMessageByImageNamed:(NSString *)imageNamed title:(NSString *)title detail:(NSString *)detail;

/**
 自定义数据展示方法 可以带操作按钮
 
 @param imageNamed 需展示的图片名字
 @param title 提示文字
 @param detail 详细文字
 @param operation 操作按钮标题 为空时不显示操作按钮
 @param block 操作按钮回调
 */
-(void)showMessageByImageNamed:(NSString *)imageNamed title:(NSString *)title detail:(NSString *)detail operation:(NSString *)operation block:(OperationBlock)block;

/**
 隐藏视图，停止服务
 */
-(void)hiddenMessageView;

@end
