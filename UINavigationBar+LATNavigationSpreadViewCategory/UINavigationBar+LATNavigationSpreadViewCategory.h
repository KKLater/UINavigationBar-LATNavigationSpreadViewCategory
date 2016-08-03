//
//  UINavigationBar+LATNavigationSpreadViewCategory.h
//  Later
//
//  Created by Later on 16/8/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LATNavigationSpreadViewCategory)
/**
 *  可以展开的视图
 */
@property (strong, nonatomic) UIView *spreadView;
/**
 *  视图是否处于展开的状态
 */
@property (assign, nonatomic, readonly) BOOL isSpreadViewShow;
/**
 *  展开视图
 */
- (void)showSpreadView;
/**
 *  隐藏视图
 */
- (void)hideSpreadView;
@end
