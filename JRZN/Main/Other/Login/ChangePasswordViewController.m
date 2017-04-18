//
//  ChangePasswordViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/6.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  设置按钮是否可用的信号
     */
    [self setupVerificationButtonEnableSignal];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 设置按钮是否可用的信号

- (void)setupVerificationButtonEnableSignal{
    // 设置密码是否合法的信号
    // map用于改变信号返回的值，在信号中判断后，返回bool值
    RACSignal *usernameSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *usernameText) {
        NSUInteger length = usernameText.length;
        if (length >= 6 && length <= kMaxpasswordNums) {
            return @(YES);
        }
        return @(NO);
    }];
    // 设置密码是否合法的信号
    RACSignal *passwordSignal = [self.ConfirmPasswordTextField.rac_textSignal map:^id(NSString *passwordText) {
        NSUInteger length = passwordText.length;
        if (length >= 6 && length <= kMaxpasswordNums && (self.passwordTextField.text == self.ConfirmPasswordTextField.text)) {
            return @(YES);
        }
        return @(NO);
    }];
    // 绑定用户名、密码、判断结果的两个信号量，如果两个都为真，则按钮可用
    RAC(self.confirmButton, enabled) = [RACSignal combineLatest:@[usernameSignal, passwordSignal] reduce:^(NSNumber *isUsernameCorrect, NSNumber *isPasswordCorrect){
        if (isUsernameCorrect.boolValue && isPasswordCorrect.boolValue) {
            [self.confirmButton setBackgroundColor:kTabbarHighlightedColor];
        }else{
            [self.confirmButton setBackgroundColor:kButtonBgGrayColor];
        }
        return @(isUsernameCorrect.boolValue && isPasswordCorrect.boolValue);
    }];
    
    
    [self.passwordTextField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.passwordTextField.text.length > kMaxpasswordNums) {
            self.passwordTextField.text = [self.passwordTextField.text substringToIndex:kMaxpasswordNums];
        }
    }];
    
    [self.ConfirmPasswordTextField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.ConfirmPasswordTextField.text.length > kMaxpasswordNums) {
            self.ConfirmPasswordTextField.text = [self.passwordTextField.text substringToIndex:kMaxpasswordNums];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
