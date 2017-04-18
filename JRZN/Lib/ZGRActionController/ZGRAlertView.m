//
//  ZGRAlertView.m
//  test
//
//  Created by 曾国锐 on 16/1/7.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "ZGRAlertView.h"

// 按钮高度
#define BUTTON_H 49.0f
// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
// 颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
//按钮颜色
#define BUTTONCOLOR LCColor(7, 135, 255)
//按钮高亮颜色
#define BUTTONHEIGHTCOLOR LCColor(7, 238, 255)

@interface ZGRAlertView () {
    
    /** 所有按钮 */
    NSArray *_buttonTitles;
    
    /** 暗黑色的view */
    UIView *_darkView;
    
    /** 所有按钮的底部view */
    UIView *_bottomView;
    
    /** 代理 */
    id<ZGRAlertViewDelegate> _delegate;
    
    /**按钮颜色**/
    UIColor *buttonColor;
    
    /**按钮高亮颜色**/
    UIColor *buttonHeightColor;
    
    /**按钮数量**/
    int buttonCount;
}

@property (nonatomic, strong) UIWindow *backWindow;


@end

@implementation ZGRAlertView

+ (instancetype)alertWithTitle:(NSString *)title detailWithTitle:(NSString *)detailTitle buttonTitles:(NSArray *)titles redButtonIndex:(NSInteger)buttonIndex delegate:(id<ZGRAlertViewDelegate>)delegate{

    return [[self alloc] initWithTitle:title detailWithTitle:detailTitle buttonTitles:titles redButtonIndex:buttonIndex delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title
                 detailWithTitle:(NSString *)detailtitle buttonTitles:(NSArray *)titles
               redButtonIndex:(NSInteger)buttonIndex
                     delegate:(id<ZGRAlertViewDelegate>)delegate {
    
    if (self = [super init]) {
        
        buttonCount = (int)titles.count;
        _delegate = delegate;
        
        // 暗黑色的view
        UIView *darkView = [[UIView alloc] init];
        [darkView setAlpha:0];
        //[darkView setUserInteractionEnabled:NO];
        [darkView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [darkView setBackgroundColor:LCColor(46, 49, 50)];
        [self.backWindow addSubview:darkView];
        self.userInteractionEnabled = YES;
        darkView.userInteractionEnabled = YES;
        _darkView = darkView;
        
        //弹出按钮
        UIView *middleView = [[UIView alloc] init];
        if (title) {
            middleView.frame = CGRectMake(SCREEN_SIZE.width/2-140, SCREEN_SIZE.height/2-70-titles.count*BUTTON_H/2, 280, 100+titles.count*BUTTON_H);
        }else{
        
            middleView.frame = CGRectMake(SCREEN_SIZE.width/2-140, SCREEN_SIZE.height/2-70-titles.count*BUTTON_H/2, 280, 100+titles.count*BUTTON_H-20);
        }
        
        middleView.backgroundColor = [UIColor whiteColor];
        [self.backWindow addSubview:middleView];
        middleView.userInteractionEnabled = YES;
        middleView.layer.cornerRadius = 5;
        middleView.layer.masksToBounds = YES;
        
        float tempHeight = 0;
        
        if (titles.count == 0) {
            
            if (title) {
                UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleView.frame.size.width/2-130, 15, 260, 20)];
                promptLabel.text = title;
                promptLabel.font = [UIFont boldSystemFontOfSize:16];
                promptLabel.textColor = [UIColor blackColor];
                promptLabel.textAlignment = NSTextAlignmentCenter;
                [middleView addSubview:promptLabel];
                
                tempHeight += 20;
            }
            
            if (detailtitle) {
                UILabel *promptDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleView.frame.size.width/2-130, 20+tempHeight, 260, 40)];
                promptDetailLabel.text = detailtitle;
                promptDetailLabel.font = [UIFont systemFontOfSize:14];
                promptDetailLabel.lineBreakMode=NSLineBreakByWordWrapping;
                promptDetailLabel.numberOfLines = 0;
                promptDetailLabel.textColor = [UIColor grayColor];
                promptDetailLabel.textAlignment = NSTextAlignmentCenter;
                [middleView addSubview:promptDetailLabel];
            }
        }
        
        if (titles.count ==1) {
            if (title) {
                UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleView.frame.size.width/2-130, 15, 260, 20)];
                promptLabel.text = title;
                promptLabel.font = [UIFont boldSystemFontOfSize:16];
                promptLabel.textColor = [UIColor blackColor];
                promptLabel.textAlignment = NSTextAlignmentCenter;
                [middleView addSubview:promptLabel];
                
                tempHeight += 20;
            }
            
            if (detailtitle) {
                UILabel *promptDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleView.frame.size.width/2-130, 20+tempHeight, 260, 40)];
                promptDetailLabel.text = detailtitle;
                promptDetailLabel.font = [UIFont systemFontOfSize:14];
                promptDetailLabel.lineBreakMode=NSLineBreakByWordWrapping;
                promptDetailLabel.numberOfLines = 0;
                promptDetailLabel.textColor = [UIColor grayColor];
                promptDetailLabel.textAlignment = NSTextAlignmentCenter;
                [middleView addSubview:promptDetailLabel];
            }
            
            // 线条
            UIImageView *line = [[UIImageView alloc] init];
            line.backgroundColor = [UIColor lightGrayColor];
            [line setContentMode:UIViewContentModeCenter];
            [line setFrame:CGRectMake(0, middleView.frame.size.height-BUTTON_H, middleView.frame.size.width, 1.0f)];
            line.alpha = 0.5;
            [middleView addSubview:line];
            
            //按钮
            UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            middleButton.frame = CGRectMake(0, middleView.frame.size.height-BUTTON_H, middleView.frame.size.width, BUTTON_H);
            [middleButton setTitle:titles[0] forState:UIControlStateNormal];
            [middleButton setTitleColor:BUTTONCOLOR forState:UIControlStateNormal];
            [middleButton setTitleColor:BUTTONHEIGHTCOLOR forState:UIControlStateHighlighted];
            middleButton.tag = 0;
            [middleButton addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [middleView addSubview:middleButton];
        }
        
        if (titles.count == 2) {
            
            if (title) {
                middleView.frame = CGRectMake(SCREEN_SIZE.width/2-140, SCREEN_SIZE.height/2-70-titles.count*BUTTON_H/2, 280, 100+(titles.count-1)*BUTTON_H);
            }else{
                
                middleView.frame = CGRectMake(SCREEN_SIZE.width/2-140, SCREEN_SIZE.height/2-70-titles.count*BUTTON_H/2, 280, 100+(titles.count-1)*BUTTON_H-20);
            }
            
            if (title) {
                UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleView.frame.size.width/2-130, 15, 260, 20)];
                promptLabel.text = title;
                promptLabel.font = [UIFont boldSystemFontOfSize:16];
                promptLabel.textColor = [UIColor blackColor];
                promptLabel.textAlignment = NSTextAlignmentCenter;
                [middleView addSubview:promptLabel];
                
                tempHeight += 20;
            }
            
            if (detailtitle) {
                UILabel *promptDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleView.frame.size.width/2-130, 20+tempHeight, 260, 40)];
                promptDetailLabel.text = detailtitle;
                promptDetailLabel.font = [UIFont systemFontOfSize:14];
                promptDetailLabel.lineBreakMode=NSLineBreakByWordWrapping;
                promptDetailLabel.numberOfLines = 0;
                promptDetailLabel.textColor = [UIColor grayColor];
                promptDetailLabel.textAlignment = NSTextAlignmentCenter;
                [middleView addSubview:promptDetailLabel];
            }
            
            // 线条
            UIImageView *line = [[UIImageView alloc] init];
            line.backgroundColor = [UIColor lightGrayColor];
            [line setContentMode:UIViewContentModeCenter];
            [line setFrame:CGRectMake(0, middleView.frame.size.height-BUTTON_H, middleView.frame.size.width, 1.0f)];
            line.alpha = 0.5;
            [middleView addSubview:line];
            
            UIImageView *verticalLine = [[UIImageView alloc] init];
            verticalLine.frame = CGRectMake(middleView.frame.size.width/2-0.5, middleView.frame.size.height-BUTTON_H, 1, BUTTON_H);
            verticalLine.backgroundColor = [UIColor lightGrayColor];
            verticalLine.alpha = 0.5;
            [middleView addSubview:verticalLine];
            
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(0, middleView.frame.size.height-BUTTON_H, middleView.frame.size.width/2, BUTTON_H);
            [leftButton setTitle:titles[0] forState:UIControlStateNormal];
            [leftButton setTitleColor:BUTTONCOLOR forState:UIControlStateNormal];
            [leftButton setTitleColor:BUTTONHEIGHTCOLOR forState:UIControlStateHighlighted];
            leftButton.tag = 0;
            [leftButton addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [middleView addSubview:leftButton];
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rightButton.frame = CGRectMake(middleView.frame.size.width/2, middleView.frame.size.height-BUTTON_H, middleView.frame.size.width/2, BUTTON_H);
            [rightButton setTitle:titles[1] forState:UIControlStateNormal];
            [rightButton setTitleColor:BUTTONCOLOR forState:UIControlStateNormal];
            [rightButton setTitleColor:BUTTONHEIGHTCOLOR forState:UIControlStateHighlighted];
            rightButton.tag = 1;
            [middleView addSubview:rightButton];
            [rightButton addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (titles.count > 2) {
            
            if (title) {
                UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleView.frame.size.width/2-130, 15, 260, 20)];
                promptLabel.text = title;
                promptLabel.font = [UIFont boldSystemFontOfSize:16];
                promptLabel.textColor = [UIColor blackColor];
                promptLabel.textAlignment = NSTextAlignmentCenter;
                [middleView addSubview:promptLabel];
                
                tempHeight += 20;
            }
            
            if (detailtitle) {
                UILabel *promptDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleView.frame.size.width/2-130, 20+tempHeight, 260, 40)];
                promptDetailLabel.text = detailtitle;
                promptDetailLabel.font = [UIFont systemFontOfSize:14];
                promptDetailLabel.lineBreakMode=NSLineBreakByWordWrapping;
                promptDetailLabel.numberOfLines = 0;
                promptDetailLabel.textColor = [UIColor grayColor];
                promptDetailLabel.textAlignment = NSTextAlignmentCenter;
                [middleView addSubview:promptDetailLabel];
            }
            
            
            
            for (int i=0; i<titles.count; i++) {

                // 线条
                UIImageView *line = [[UIImageView alloc] init];
                line.backgroundColor = [UIColor lightGrayColor];
                [line setContentMode:UIViewContentModeCenter];
                [line setFrame:CGRectMake(0, middleView.frame.size.height-(BUTTON_H*(titles.count-i)), middleView.frame.size.width, 1.0f)];
                line.alpha = 0.5;
                [middleView addSubview:line];
                
                UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
                Button.frame = CGRectMake(0, middleView.frame.size.height-(BUTTON_H*(titles.count-i)), middleView.frame.size.width, BUTTON_H);
                [Button setTitle:titles[i] forState:UIControlStateNormal];
                [Button setTitleColor:BUTTONCOLOR forState:UIControlStateNormal];
                [Button setTitleColor:BUTTONHEIGHTCOLOR forState:UIControlStateHighlighted];
                Button.tag = i;
                [middleView addSubview:Button];
                [Button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        [self.backWindow addSubview:self];
    }
    
    
    return self;
}

- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}

- (void)didClickBtn:(UIButton *)btn {
    
    [self dismiss];
    
    if ([_delegate respondsToSelector:@selector(alertView:didClickedButtonAtIndex:)]) {
        
        [_delegate alertView:self didClickedButtonAtIndex:btn.tag];
    }
}

- (void)dismiss{
    
    _backWindow.hidden = YES;
    
    [self removeFromSuperview];
}

- (void)didClickCancelBtn {
    
    _backWindow.hidden = YES;
    
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(alertView:didClickedButtonAtIndex:)]) {
        
        [_delegate alertView:self didClickedButtonAtIndex:_buttonTitles.count];
    }
}

- (void)show {
    
    _backWindow.hidden = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0.4f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                     }
                     completion:nil];
}

@end
