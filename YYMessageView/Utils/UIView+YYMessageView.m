//
//  UIView+YYMessageView.m
//  Demo_Message
//
//  Created by shifangyuan on 2017/3/6.
//  Copyright © 2017年 石方圆. All rights reserved.
//

#import "UIView+YYMessageView.h"
#import "YYMessageView.h"

#import <objc/runtime.h>
#import <objc/message.h>

#define loadkey @"YYMessageViewKey"

@interface UIView ()

@property (readonly, nonatomic) YYMessageView *yy_messageView;

@end

@implementation UIView (YYMessageView)

-(YYMessageView *)yy_messageView
{
    YYMessageView *messageView = [self yy_messageViewAssociated];
    if (!messageView)
    {
        CGRect rect = self.frame;
        rect.origin.y = 0;
        
        messageView = [[YYMessageView alloc] initWithFrame:rect];
        
        self.yy_messageView = messageView;
        
        self.yy_messageView.backgroundColor = [UIColor whiteColor];
        
        [self setYy_messageView:messageView];
    }
    
    if (!messageView.superview)
    {
        [self addSubview:messageView];
    }
    
    return messageView;
}

-(void)setYy_messageView:(YYMessageView *)yy_messageView
{
    YYMessageView *associated_messageView = [self yy_messageViewAssociated];
    
    if (associated_messageView)
    {
        [associated_messageView removeFromSuperview];
        
        objc_removeAssociatedObjects(associated_messageView);
    }
    
    objc_setAssociatedObject(self, loadkey, yy_messageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (yy_messageView)
    {
        [self swizzleMethod:NSSelectorFromString(@"didMoveToSuperview") withMethod:@selector(yy_didMoveToSuperview)];
        [self swizzleMethod:NSSelectorFromString(@"willMoveToSuperview") withMethod:@selector(yy_willMoveToSuperview:)];
        [self swizzleMethod:NSSelectorFromString(@"removeFromSuperview") withMethod:@selector(yy_removeFromSuperview)];
    }
}

#pragma mark - Swizzled Methods
- (void)yy_removeFromSuperview
{
    [self destroyMessageView];
    [self yy_removeFromSuperview];
}

- (void)yy_didMoveToSuperview
{
    if (!self.superview || !self.window)
    {
        [self destroyMessageView];
    }
    
    [self yy_didMoveToSuperview];
}

- (void)yy_willMoveToSuperview:(UIView *)newSuperview
{
    if (!self.window)
    {
        [self destroyMessageView];
    }
    
    [self yy_willMoveToSuperview:newSuperview];
}

- (void) destroyMessageView
{
    @synchronized(self)
    {
        if (self.yy_messageViewAssociated)
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self.yy_messageViewAssociated];
            
            @try
            {
                [self.yy_messageViewAssociated removeFromSuperview];
            }
            @catch (NSException *exception) {}
            
            [self setYy_messageView:nil];
        }
    }
}

-(YYMessageView *)yy_messageViewAssociated
{
    return objc_getAssociatedObject(self, loadkey);
    
    return nil;
}

- (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod([self class],
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod([self class],
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark -- 方法区域
-(void)showMessageNotData
{
    [self.yy_messageView setupDefaultValues];
    
    [self.yy_messageView showMessageWithNotData];
}

-(void)showMessageNotNetwork:(OperationBlock)block
{
    [self.yy_messageView setupDefaultValues];
    
    [self.yy_messageView showMessageWithNotNetwork];
    
    [self.yy_messageView setOperationBlock:^{
        if (block) {
            block();
        }
    }];
}

-(void)showMessageByImageNamed:(NSString *)imageNamed title:(NSString *)title detail:(NSString *)detail
{
    [self.yy_messageView setupDefaultValues];
    
    [self.yy_messageView showMessageWithImageNamed:imageNamed
                                             title:title
                                            detail:detail];
}

-(void)hiddenMessageView
{
    YYMessageView *messageView = [self yy_messageViewAssociated];
    if (messageView) {
        [messageView hiddenMessageView];
    }
    
}

@end
