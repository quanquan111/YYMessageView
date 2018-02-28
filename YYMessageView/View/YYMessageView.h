/*!
 
 @header YYMessageView.h
 
 @abstract 源代码文件基本描述
 
 @author Created by shifangyuan on 16/8/25.
 
 @version 1.0.0 16/8/25 Creation
 
 @  Copyright © 2016年 石方圆. All rights reserved.
 
 */


#import <UIKit/UIKit.h>

@interface YYMessageView : UIView

/*!
 *回调block
 */
@property (strong, nonatomic) void(^operationBlock)(void);

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
 标题大小
 */
@property (assign, nonatomic) CGFloat fontSize;

/**
 *图片的高度（如果设置此值宽度必将自适应，不设置则为固定宽高，初始化宽高在图片视图懒加载方法里面进行赋值）
 */
@property (assign, nonatomic) CGFloat imageHeight;

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

/**
 自定义数据展示方法 创建实例时调用的方法

 @param imageNamed 显示的图片名字
 @param title 标题
 @param detail 详细说明
 @param operation 操作按钮文字 可为空
 */
-(void)showMessageWithImageNamed:(NSString *)imageNamed title:(NSString *)title detail:(NSString *)detail operation:(NSString *)operation;

@end

