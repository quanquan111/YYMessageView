/*!
 
 @header YYMessageView.m
 
 @abstract 源代码文件基本描述 通用提示视图
 
 @author Created by shifangyuan on 16/8/25.
 
 @version 1.0.0 16/8/25 Creation
 
 @  Copyright © 2016年 石方圆. All rights reserved.
 
 */

#import "YYMessageView.h"

@interface YYMessageView()
///视图宽
@property (assign, nonatomic) CGFloat swidth;
///视图高
@property (assign, nonatomic) CGFloat sheight;

@end

@implementation YYMessageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) { [self setupDefaultValues]; }
    return self; 
}

-(instancetype)init {
    self = [super init];
    if (self) { [self setupDefaultValues]; }
    return self;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setupDefaultValues];
}

#pragma mark -- 设置默认值
-(void)setupDefaultValues {
    self.hidden = YES;
    self.swidth = self.frame.size.width;
    self.sheight = self.frame.size.height;
    
    self.fontSize = 16;
    self.imageHeight = 120;
    self.messageColor = [UIColor grayColor];
    self.detailsLabelColor = [UIColor grayColor];
    self.operationColor = [UIColor redColor];
    self.actionButtonTitle = @"立即刷新";
}

#pragma mark -- private
/**
 私有方法 初始化控件
 
 @param imageNamed 图片名字
 @param titleText 提示文字
 @param detailText 详细信息
 @param sender 是否有操作按钮 (无网络的时候显示的按钮,点击之后回调重新获取数据)
 */
-(void)showMessageByImageNamed:(NSString *)imageNamed andTitle:(NSString *)titleText andDetail:(NSString *)detailText andSender:(BOOL)sender
{
    //显示视图
    self.hidden = NO;
    //判断是否显示详情 并设置
    BOOL showDetails = NO;
    if (detailText != nil || detailText.length > 0) {
        showDetails = YES;
        self.detailsLabel.text = detailText;
        [self.detailsLabel sizeToFit];
    }
    
    //设置显示标题
    self.showMessageLabel.text = titleText;
    [self.showMessageLabel sizeToFit];
    
    //需要显示的图片
    UIImage *showImage = [self bundleWithImageNamed:imageNamed];
    //计算图片的Y坐标
    CGRect rect = self.showImageView.frame;
    //如果设置有自适应高度则替换原固定宽高 并更新x坐标
    if (self.imageHeight > 0.0) {
        rect.size.height = self.imageHeight;
        rect.size.width = showImage.size.width*self.imageHeight/showImage.size.height;
        rect.origin.x = (self.swidth - rect.size.width)/2;
    }
    //计算图片Y坐标
    rect.origin.y = (self.sheight - rect.size.height - self.showMessageLabel.frame.size.height - 10)/2;
    //操作按钮
    if (sender) {
        rect.origin.y -= (self.actionButton.frame.size.height + 15)/2;
    }
    //详情
    if (showDetails) {
        rect.origin.y -= (self.detailsLabel.frame.size.height + 6)/2;
    }
    //设置图片Frame
    self.showImageView.frame = rect;
    //设置图片
    self.showImageView.image = showImage;
    
    //设置提示文字Frame
    rect = self.showMessageLabel.frame;
    rect.origin.y = CGRectGetMaxY(self.showImageView.frame) + 10;
    rect.size.width = self.swidth - 30;
    self.showMessageLabel.frame = rect;
    
    //设置详情Frame
    if (showDetails) {
        rect = self.detailsLabel.frame;
        rect.origin.y = CGRectGetMaxY(self.showMessageLabel.frame) + 6;
        rect.size.width = self.swidth - 30;
        self.detailsLabel.frame = rect;
    }
    
    //设置操作按钮Frame
    if (sender) {
        rect = self.actionButton.frame;
        rect.size.width = [self boundingRectWithSize:CGSizeMake(self.swidth - 30, rect.size.height) string:self.actionButtonTitle fontSize:self.fontSize].width + 40;
        rect.origin.x = (self.swidth - rect.size.width)/2;
        rect.origin.y = CGRectGetMaxY(showDetails?self.detailsLabel.frame:self.showMessageLabel.frame) + 15;
        self.actionButton.frame = rect;
        [self.actionButton setTitle:self.actionButtonTitle forState:UIControlStateNormal];
        self.actionButton.hidden = NO;
    }else{
        if (_actionButton) {
            self.actionButton.hidden = YES;
        }
    }
}

/// 清除视图
-(void)clear
{
    if (_showMessageLabel) {
        [self.showMessageLabel removeFromSuperview];
        self.showMessageLabel = nil;
    }
    
    if (_actionButton) {
        [self.actionButton removeFromSuperview];
        self.actionButton = nil;
    }
    
    if (_showImageView) {
        [self.showImageView removeFromSuperview];
        self.showImageView = nil;
    }
    
    if (_detailsLabel) {
        [self.detailsLabel removeFromSuperview];
        self.detailsLabel = nil;
    }
    
    self.completeBlock = nil;
    self.operationColor = nil;
    self.messageColor = nil;
    self.detailsLabelColor = nil;
    self.actionButtonTitle = nil;
    
    [self removeFromSuperview];
}

#pragma mark -- public
#pragma mark -- 隐藏视图 (停止服务，销毁视图)
-(void)hiddenMessageView
{
    //隐藏视图
    self.hidden = YES;
    [self clear];
}

#pragma mark -- 自定义方法区 (init ImageMessageView)
/**
 默认的无数据展示方法
 */
-(void)showMessageWithNotData
{
    [self showMessageByImageNamed:@"data_not"
                         andTitle:@"暂无相关数据"
                        andDetail:nil
                        andSender:NO];
}

/**
 默认的无网络连接的展示方法
 */
-(void)showMessageWithNotNetwork
{
    [self showMessageByImageNamed:@"error_nwork"
                         andTitle:@"网络走丢了"
                        andDetail:@"世界上最遥远的距离莫过于此"
                        andSender:YES];
}

/**
 自定义数据展示方法 默认是没有操作按钮的
 
 @param imageNamed 需展示的图片名字
 @param title 提示文字
 @param detail 详细文字
 */
-(void)showMessageWithImageNamed:(NSString *)imageNamed title:(NSString *)title detail:(NSString *)detail
{
    [self showMessageByImageNamed:imageNamed
                         andTitle:title
                        andDetail:detail
                        andSender:NO];
}

-(void)showMessageWithImageNamed:(NSString *)imageNamed title:(NSString *)title detail:(NSString *)detail operation:(NSString *)operation
{
    //容错 判断是否有操作按钮
    BOOL sender = YES;
    self.actionButtonTitle = operation;
    if (operation == nil || [operation isEqualToString:@""]) {
        sender = NO;
        self.actionButtonTitle = @"立即刷新";
    }
    
    [self showMessageByImageNamed:imageNamed
                         andTitle:title
                        andDetail:detail
                        andSender:sender];
}

#pragma mark -- action
-(void)operationAction:(UIButton *)sender
{
    if (self.completeBlock) {
        self.completeBlock();
    }
}

#pragma mark -- 计算字符串size
-(CGSize)boundingRectWithSize:(CGSize)size string:(NSString *)str fontSize:(float)fontSize
{
    CGRect rect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
    return rect.size;
}

#pragma mark -- 获取资源文件
-(UIImage *)bundleWithImageNamed:(NSString *)imageNamed {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"YYMessageImage" ofType:@"bundle"]];
    }
    NSString *path = [bundle pathForResource:imageNamed ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

#pragma mark -- 懒加载创建控件。 简单设置数据
//创建提示文字控件
-(UILabel *)showMessageLabel
{
    if (!_showMessageLabel) {
        _showMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.swidth - 30, 0)];
        _showMessageLabel.font = [UIFont systemFontOfSize:self.fontSize];
        _showMessageLabel.textColor = self.messageColor;
        _showMessageLabel.numberOfLines = 0;
        _showMessageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_showMessageLabel];
    }
    
    return _showMessageLabel;
}

//创建详细说明控件
-(UILabel *)detailsLabel
{
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.swidth - 30, 0)];
        _detailsLabel.font = [UIFont systemFontOfSize:self.fontSize - 2];
        _detailsLabel.textColor = self.detailsLabelColor;
        _detailsLabel.numberOfLines = 0;
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_detailsLabel];
    }
    
    return _detailsLabel;
}

//创建操作按钮
-(UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 36)];
        [_actionButton setTitleColor:self.operationColor forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        _actionButton.layer.cornerRadius = 4;
        _actionButton.layer.borderWidth = 0.5;
        _actionButton.layer.borderColor = self.operationColor.CGColor;
        _actionButton.layer.masksToBounds = YES;
        [_actionButton addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_actionButton];
    }
    
    return _actionButton;
}

//创建图片视图
-(UIImageView *)showImageView
{
    if (!_showImageView) {
        //图片大小  宽高
        float twidth = 140;
        float theight = 140;
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.swidth - twidth)/2, (self.sheight - theight)/2, twidth, theight)];
        [self addSubview:_showImageView];
    }
    
    return _showImageView;
}

-(void)dealloc
{
    [self clear];
}

@end

