//
//  ForgotPasswordViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/6.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "VerificationButton.h"

@interface ForgotPasswordViewController ()<VerificationButtonDelegate>
{
    BOOL tempBool;//临时倒计时属性监听
}
/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
/**
 *  验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *verficationField;
/**
 *  获取验证码
 */
@property (weak, nonatomic) IBOutlet VerificationButton *verificationButton;
/**
 *  下一步
 */
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation ForgotPasswordViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    tempBool = YES;
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.verificationButton.customDelegate = self;
    
    /**
     *  设置按钮是否可用的信号
     */
    [self setupVerificationButtonEnableSignal];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma makr - 获取验证码
- (IBAction)verificationClick:(id)sender {
    
    DDLog(@"获取验证码");
}
- (IBAction)nextButtonClick:(id)sender {
    
    UIViewController *vc = [NSClassFromString(@"ChangePasswordViewController") new];
    vc.title = @"重设密码";
    [self.navigationController pushViewController:vc animated:YES];
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
        if (length == kMaxPhoneNums && [Global isMobileNumber:usernameText]) {
            return @(YES);
        }
        return @(NO);
    }];
    
    // 绑定用户名、密码、判断结果的两个信号量，如果两个都为真，则按钮可用
    RAC(self.verificationButton, enabled) = [RACSignal combineLatest:@[usernameSignal] reduce:^(NSNumber *isUsernameCorrect){
        if (isUsernameCorrect.boolValue && tempBool) {
            [self.verificationButton setBackgroundColor:kTabbarHighlightedColor];
        }else{
            [self.verificationButton setBackgroundColor:kButtonBgGrayColor];
        }
        return @(isUsernameCorrect.boolValue);
    }];
    
    
    RACSignal *verificationSignal = [self.verficationField.rac_textSignal map:^id(NSString *verificationText) {
        NSUInteger length = verificationText.length;
        if (length == kMaxVerficationNums) {
            return @(YES);
        }
        return @(NO);
    }];
    
    // 下一步
    RAC(self.nextButton, enabled) = [RACSignal combineLatest:@[usernameSignal ,verificationSignal] reduce:^(NSNumber *isUsernameCorrect, NSNumber *isVerificationCorrect){
        if (isUsernameCorrect.boolValue && isVerificationCorrect.boolValue) {
            [self.nextButton setBackgroundColor:kTabbarHighlightedColor];
        }else{
            [self.nextButton setBackgroundColor:kButtonBgGrayColor];
        }
        return @(isUsernameCorrect.boolValue && isVerificationCorrect.boolValue);
    }];
    
    [self.phoneTextField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.phoneTextField.text.length > kMaxPhoneNums) {
            self.phoneTextField.text = [self.phoneTextField.text substringToIndex:kMaxPhoneNums];
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
