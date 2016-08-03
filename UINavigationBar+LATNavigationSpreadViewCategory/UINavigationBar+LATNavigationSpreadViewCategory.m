//
//  UINavigationBar+LATNavigationSpreadViewCategory.m
//  Later
//
//  Created by Later on 16/8/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "UINavigationBar+LATNavigationSpreadViewCategory.h"
#import <objc/runtime.h>

@interface UINavigationBar ()
@property (assign, nonatomic, readwrite) BOOL isSpreadViewShow;
@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) CGFloat showY;
@property (assign, nonatomic) CGFloat hideY;
@property (assign, nonatomic) BOOL isAnimation;
@end
@implementation UINavigationBar (LATNavigationSpreadViewCategory)
#pragma mark SyetemMethod
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (self.isAnimation || (self.isSpreadViewShow && view == nil)) {
        CGPoint tempoint = [self.backView convertPoint:point fromView:self];
       if (CGRectContainsPoint(self.backView.bounds, tempoint)) {
            view = self.backView;
           CGPoint temSpreadPoint = [self.spreadView convertPoint:point fromView:self];
           if (CGRectContainsPoint(self.spreadView.bounds, temSpreadPoint))
           {
               view = self.spreadView;
           }
        }
    }
    return view;
}
#pragma mark Gesture
- (void)tap {
    [self hideSpreadView];
}
#pragma mark PublicMethod
- (void)showSpreadView {
    if (!self.isAnimation && !self.isSpreadViewShow) {
        self.isAnimation = YES;
        [self.backView addSubview:self.spreadView];
        self.spreadView.frame = CGRectMake(CGRectGetMinX(self.spreadView.bounds), self.hideY, CGRectGetWidth(self.spreadView.bounds), CGRectGetHeight(self.spreadView.bounds));
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.backView.alpha = 1;
            self.spreadView.frame = CGRectMake(CGRectGetMinX(self.spreadView.bounds), self.showY, CGRectGetWidth(self.spreadView.bounds), CGRectGetHeight(self.spreadView.bounds));
        } completion:^(BOOL finished) {
            self.isSpreadViewShow = YES;
            self.isAnimation = NO;
        }];
    }
}
- (void)hideSpreadView {
    if (!self.isAnimation && self.isSpreadViewShow) {
        self.isAnimation = YES;
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backView.alpha = 0;
            self.spreadView.frame = CGRectMake(CGRectGetMinX(self.spreadView.bounds),  self.hideY, CGRectGetWidth(self.spreadView.bounds), CGRectGetHeight(self.spreadView.bounds));
        } completion:^(BOOL finished) {
            self.isSpreadViewShow = NO;
            self.isAnimation = NO;
            [self.spreadView removeFromSuperview];
        }];
    }
    
}
#pragma mark Setter/Getter
- (UIView *)spreadView {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSpreadView:(UIView *)spreadView {
    UIView *view = objc_getAssociatedObject(self, @selector(spreadView));
    if ([view isEqual:spreadView]) {
        return;
    }
    objc_setAssociatedObject(self, @selector(spreadView), spreadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.showY = CGRectGetMinY(spreadView.bounds);
    self.hideY = - CGRectGetHeight(spreadView.bounds)-CGRectGetMaxY(self.bounds)-64;
    [self insertSubview:self.backView atIndex:0];
}
- (UIView *)backView {
    UIView *backView = objc_getAssociatedObject(self, _cmd);
    if (!backView) {
        backView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.bounds), CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-CGRectGetMaxY(self.bounds))];
        backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        backView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [backView addGestureRecognizer:tap];
        objc_setAssociatedObject(self, _cmd, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backView;
    
}
- (void)setBackView:(UIView *)backView {
    objc_setAssociatedObject(self, @selector(backView), backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)showY {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setShowY:(CGFloat)showY {
    objc_setAssociatedObject(self, @selector(showY), @(showY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)hideY {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setHideY:(CGFloat)hideY {
    objc_setAssociatedObject(self, @selector(hideY), @(hideY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isSpreadViewShow {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsSpreadViewShow:(BOOL)isSpreadViewShow {
    objc_setAssociatedObject(self, @selector(isSpreadViewShow), @(isSpreadViewShow), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)isAnimation {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsAnimation:(BOOL)isAnimation {
    objc_setAssociatedObject(self, @selector(isAnimation), @(isAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
