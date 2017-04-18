//
//  RegisterViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/6.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerificationButton.h"

@interface RegisterViewController ()<VerificationButtonDelegate>
{
    BOOL tempBool;//临时倒计时属性监听
}
/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
/**
 *  密码
 */
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
/**
 *  确认密码
 */
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPasswordTextField;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
/**
 *  验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *verficationField;
/**
 *  获取验证码
 */
@property (weak, nonatomic) IBOutlet VerificationButton *verificationButton;
/**
 *  注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;
@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    tempBool = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.verificationButton.customDelegate = self;
    /**
     *  设置按钮是否可用的信号
     */
//    [self setupVerificationButtonEnableSignal];
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 设置验证码按钮是否可用的信号
/**
 *  设置验证码按钮是否可用的信号
 */
- (void)setupVerificationButtonEnableSignal{
    // 设置用户名是否合法的信号
    // map用于改变信号返回的值，在信号中判断后，返回bool值
    RACSignal *usernameSignal = [self.phoneTextField.rac_textSignal map:^id(NSString *usernameText) {
        NSUInteger length = usernameText.length;
        if (length == 11 && [Global isMobileNumber:usernameText]) {
            return @(YES);
        }
        return @(NO);
    }];
    
    // 设置密码是否合法的信号
    RACSignal *passwordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *passwordText) {
        NSUInteger length = passwordText.length;
        if (length >= 6 && length <= 16) {
            return @(YES);
        }
        return @(NO);
    }];
    
    // 确认密码
    RACSignal *confirmPasswordSignal = [self.ConfirmPasswordTextField.rac_textSignal map:^id(NSString *passwordText) {
        NSUInteger length = passwordText.length;
        if (length >= 6 && length <= 16) {
            if (self.passwordTextField.text == passwordText) {
                return @(YES);
            }else{
                DDLog(@"2次密码输入不一致");
            }
        }
        return @(NO);
    }];
    
    // 昵称
    RACSignal *nickNameSignal = [self.nickNameTextField.rac_textSignal map:^id(NSString *nickNameText) {
        NSUInteger length = nickNameText.length;
        if (length >= 2 && length <= 10) {
            return @(YES);
        }
        return @(NO);
    }];
    
    
    //验证码tf
    RACSignal *verificationSignal = [self.verficationField.rac_textSignal map:^id(NSString *verificationText) {
        NSUInteger length = verificationText.length;
        if (length == 6) {
            return @(YES);
        }
        return @(NO);
    }];
    
    // 绑定用户名、密码、判断结果的两个信号量，如果两个都为真，则按钮可用
    //验证码按钮
    RAC(self.verificationButton, enabled) = [RACSignal combineLatest:@[usernameSignal] reduce:^(NSNumber *isUsernameCorrect){
        if (isUsernameCorrect.boolValue && tempBool) {
            [self.verificationButton setBackgroundColor:kTabbarHighlightedColor];
        }else{
            [self.verificationButton setBackgroundColor:kButtonBgGrayColor];
        }
        return @(isUsernameCorrect.boolValue);
    }];
    
    
    // 注册按钮
    RAC(self.RegisterButton, enabled) = [RACSignal combineLatest:@[usernameSignal ,verificationSignal, passwordSignal, confirmPasswordSignal, nickNameSignal] reduce:^(NSNumber *isUsernameCorrect, NSNumber *isVerificationCorrect, NSNumber *isPasswordCorrect, NSNumber *isConfirmPasswordCorrect, NSNumber *isNickNameCorrect){
        if (isUsernameCorrect.boolValue && isVerificationCorrect.boolValue && isPasswordCorrect.boolValue && isConfirmPasswordCorrect.boolValue && isNickNameCorrect.boolValue) {
            [self.RegisterButton setBackgroundColor:kTabbarHighlightedColor];
        }else{
            [self.RegisterButton setBackgroundColor:kButtonBgGrayColor];
        }
        return @(isUsernameCorrect.boolValue && isVerificationCorrect.boolValue && isPasswordCorrect.boolValue && isConfirmPasswordCorrect.boolValue && isNickNameCorrect.boolValue);
    }];
    
    [self.phoneTextField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.phoneTextField.text.length > kMaxPhoneNums) {
            self.phoneTextField.text = [self.phoneTextField.text substringToIndex:kMaxPhoneNums];
        }
    }];
    
    [self.passwordTextField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.passwordTextField.text.length > kMaxpasswordNums) {
            self.passwordTextField.text = [self.passwordTextField.text substringToIndex:kMaxpasswordNums];
        }
    }];
    
    [self.ConfirmPasswordTextField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.ConfirmPasswordTextField.text.length > kMaxpasswordNums) {
            self.ConfirmPasswordTextField.text = [self.ConfirmPasswordTextField.text substringToIndex:kMaxpasswordNums];
        }
    }];
    
    [self.nickNameTextField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.nickNameTextField.text.length > kMaxNickNameNums) {
            self.nickNameTextField.text = [self.nickNameTextField.text substringToIndex:kMaxNickNameNums];
        }
    }];
    
    [self.verficationField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.verficationField.text.length > kMaxVerficationNums) {
            self.verficationField.text = [self.verficationField.text substringToIndex:kMaxVerficationNums];
        }
    }];
}

#pragma mark - 按钮倒计时结束通知代理
- (void)countdownEndNotification:(BOOL)isBool{
    
    tempBool = isBool;
}

#pragma makr - 获取验证码
- (IBAction)verificationClick:(id)sender {
    
    DDLog(@"获取验证码");
    
}

#pragma makr - 注册按钮
- (IBAction)registerButtonClick:(id)sender {
    DDLog(@"注册");
    
   
    
//    UIViewController *vc = [NSClassFromString(@"RegisterSuccessViewController") new];
//    vc.title = @"注册成功";
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma makr - 注册协议
- (IBAction)registrationAgreementClick:(id)sender {
    DDLog(@"注册协议");
    BaseWebViewController *vc = [[BaseWebViewController alloc] init];
    vc.title = @"注册协议";
    vc.webViewStaticApi = @"https://www.baidu.com";
    [self.navigationController pushViewController:vc animated:YES];
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
