//
//  VerificationButton.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/6.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  验证码按钮

#import <UIKit/UIKit.h>

@protocol VerificationButtonDelegate <NSObject>

/**
 *  倒计时通知代理
 */
- (void)countdownEndNotification:(BOOL)isBool;

@end

@interface VerificationButton : UIButton

@property (nonatomic, weak) id<VerificationButtonDelegate> customDelegate;

/** 验证码倒计时的时长 */
@property (nonatomic, assign) NSInteger durationOfCountDown;

@end
