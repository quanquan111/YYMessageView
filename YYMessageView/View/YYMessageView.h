//
//  YYMessageView.h
//  Demo_Message
//
//  Created by shifangyuan on 2017/3/6.
//  Copyright © 2017年 石方圆. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYMessageViewDelegate;

@interface YYMessageView : UIView

/*!
 *回调block
 */
@property (strong, nonatomic) void(^operationBlock)(void);

/**
 delegate
 */
@property (weak, nonatomic) id<YYMessageViewDelegate> delegate;

/*!
 *操作按钮 主题颜色
 */
@property (strong, nonatomic) UIColor *operationColor;

/*!
 *提示信息 文字颜色
 */
@property (strong, nonatomic) UIColor *messageColor;

/*!
 *详细说明 文字颜色
 */
@property (strong, nonatomic) UIColor *detailsLabelColor;

/*!
 *显示的图片视图
 */
@property (strong, nonatomic) UIImageView *showImageView;

/*!
 *显示提示信息文字Label
 */
@property (strong, nonatomic) UILabel *showMessageLabel;

/*!
 *显示详细说明
 */
@property (strong, nonatomic) UILabel *detailsLabel;

/*!
 *操作按钮
 */
@property (strong, nonatomic) UIButton *actionButton;

/*!
 *设置操作按钮标题
 */
@property (strong, nonatomic) NSString *actionButtonTitle;

/**
 初始化默认设置
 */
-(void)setupDefaultValues;

/*!
 *隐藏视图，停止服务 创建实例时调用的方法
 */
-(void)hiddenMessageView;

#pragma mark -- 自定义方法
/**
 默认的无数据展示方法 创建实例时调用的方法
 */
-(void)showMessageWithNotData;

/**
 默认的无网络连接的展示方法 创建实例时调用的方法
 */
-(void)showMessageWithNotNetwork;

/**
 自定义数据展示方法 默认是没有操作按钮的 创建实例时调用的方法
 
 @param imageNamed 需展示的图片名字
 @param title 提示文字
 @param detail 详细文字
 */
-(void)showMessageWithImageNamed:(NSString *)imageNamed title:(NSString *)title detail:(NSString *)detail;

@end



@protocol YYMessageViewDelegate <NSObject>
@optional
///网络连接失败 点击按钮的代理方法 实例化YYMessageView时使用的代理方法
-(void)yyMessageViewTouchAction;
//-(void)yyMessageViewWasHidden:(YYMessageView *)messageView;
@end
