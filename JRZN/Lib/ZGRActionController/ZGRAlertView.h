//
//  ZGRAlertView.h
//  test
//
//  Created by 曾国锐 on 16/1/7.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGRAlertView;

@protocol ZGRAlertViewDelegate <NSObject>

@optional

/**
 *  点击了 buttonIndex处 的按钮
 */
- (void)alertView:(ZGRAlertView *)alertView didClickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface ZGRAlertView : UIView

/**
 *  返回一个 alertView 对象, 类方法
 *
 *  @param title 提示标题
 *
 *  @param titles 所有按钮的标题
 *
 *  @param redButtonIndex 红色按钮的index
 *
 *  @param delegate 代理
 *
 *  Tip: 如果没有红色按钮, redButtonIndex 给 `-1` 即可
 */
+ (instancetype)alertWithTitle:(NSString *)title
               detailWithTitle:(NSString *)detailTitle  buttonTitles:(NSArray *)titles
                redButtonIndex:(NSInteger)buttonIndex
                      delegate:(id<ZGRAlertViewDelegate>)delegate;

/**
 *  返回一个 alertView 对象, 实例方法
 *
 *  @param title 提示标题
 *
 *  @param titles 所有按钮的标题
 *
 *  @param redButtonIndex 红色按钮的index
 *
 *  @param delegate 代理
 *
 *  Tip: 如果没有红色按钮, redButtonIndex 给 `-1` 即可
 */
- (instancetype)initWithTitle:(NSString *)title
                  detailWithTitle:(NSString *)title buttonTitles:(NSArray *)titles
               redButtonIndex:(NSInteger)buttonIndex
                     delegate:(id<ZGRAlertViewDelegate>)delegate;

/**
 *  显示 alertView
 */
- (void)show;

- (void)dismiss;

@end
