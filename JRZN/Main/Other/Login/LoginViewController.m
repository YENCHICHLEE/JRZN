//
//  LoginViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/6.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "IWTabBarViewController.h"
#import "ZGRNavigationController.h"
#import "ForgotPasswordViewController.h"
#import "UINavigationBar+Awesome.h"

@interface LoginViewController ()

/**
 *  手机号
 */
@property (nonatomic, strong) UITextField *phoneTestField;
/**
 *  密码
 */
@property (nonatomic, strong) UITextField *passwordTextField;
/**
 *  登录按钮
 */
@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [self.navigationController.navigationBar lt_reset];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithWhite:0.770 alpha:1.000];
    //返回按钮
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"login_icon_back"] forState:UIControlStateNormal];
//    [self.view addSubview:backButton];
//    backButton.backgroundColor = [UIColor yellowColor];
//    backButton.frame = CGRectMake(0, 27, 40, 30);
//    @weakify(self)
//    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        
//        @strongify(self)
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"login_icon_back" highIcon:@"login_icon_back" target:self action:@selector(backClick)];
    
    
    [self makeUI];
    
    /**
     *  设置登陆按钮是否可用的信号
     */
    [self setuploginButtonEnableSignal];

    
    
    // Do any additional setup after loading the view.
}

- (void)backClick{

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)makeUI{

//背景
    UIImageView *bgImageView = [UIImageView new];
    [self.view addSubview:bgImageView];
    bgImageView.image = [UIImage imageNamed:@"login_background.png"];
    
    bgImageView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .centerYIs(HEIGHT/2)
    .heightIs(750);
    
//忘记密码
    UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetPasswordButton.titleLabel.font = kDetailFont;
    forgetPasswordButton.cjr_acceptEventInterval = 1;
    [self.view addSubview:forgetPasswordButton];
    
    forgetPasswordButton.sd_layout
    .rightSpaceToView(self.view, 30)
    .centerYIs(HEIGHT/2-30)
    .widthIs(100)
    .heightIs(30);
    
    @weakify(self)
    [[forgetPasswordButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self)
        UIViewController *vc = [NSClassFromString(@"ForgotPasswordViewController") new];
        vc.title = @"找回密码";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    CGFloat margin = 50;
    
    _phoneTestField = [UITextField new];
    
    [self.view addSubview:_phoneTestField];
    _passwordTextField = [UITextField new];
    
    [self.view addSubview:_passwordTextField];
    
//密码
    
    _passwordTextField.backgroundColor = UIColorFromRGB(0x1d2332, 0.5);
    _passwordTextField.layer.cornerRadius = 3;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.placeholder = @"请输入密码";
    [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTextField.textColor = [UIColor whiteColor];
    _passwordTextField.clearButtonMode = YES;
    _passwordTextField.secureTextEntry=YES;
    
    _passwordTextField.sd_layout
    .leftSpaceToView(self.view, margin)
    .rightSpaceToView(self.view, margin)
    .bottomSpaceToView(forgetPasswordButton, 5)
    .heightIs(50);
    
    
    UIImageView *passwordLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, 12.5, 25, 25)];
    passwordLogoImageView.image=[UIImage imageNamed:@"login_icon_password.png"];
    
    
    UIView *passwordTextFieldBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [passwordTextFieldBgView addSubview:passwordLogoImageView];
    
    self.passwordTextField.leftView = passwordTextFieldBgView;
    //以上是无法显示图片的需要设置mode
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
//手机
    
    _phoneTestField.backgroundColor = UIColorFromRGB(0x1d2332, 0.5);
    _phoneTestField.layer.cornerRadius = 3;
    _phoneTestField.layer.masksToBounds = YES;
    _phoneTestField.keyboardType=UIKeyboardTypeNumberPad;
    _phoneTestField.placeholder = @"请输入手机号";
    [_phoneTestField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTestField.textColor = [UIColor whiteColor];
    _phoneTestField.clearButtonMode = YES;
    
    _phoneTestField.sd_layout
    .leftSpaceToView(self.view, margin)
    .rightSpaceToView(self.view, margin)
    .bottomSpaceToView(_passwordTextField, 10)
    .heightIs(50);
    
    
    UIImageView *phoneLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, 12.5, 25, 25)];
    phoneLogoImageView.image=[UIImage imageNamed:@"login_icon_name.png"];
    
    
    UIView *phoneTextFieldBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [phoneTextFieldBgView addSubview:phoneLogoImageView];
    
    self.phoneTestField.leftView = phoneTextFieldBgView;
    //以上是无法显示图片的需要设置mode
    self.phoneTestField.leftViewMode = UITextFieldViewModeAlways;
    
    
//登录按钮
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_loginButton];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:kTabbarHighlightedColor];
    _loginButton.layer.cornerRadius = 3;
    _loginButton.layer.masksToBounds = YES;
    
    _loginButton.sd_layout
    .leftSpaceToView(self.view, margin)
    .rightSpaceToView(self.view, margin)
    .topSpaceToView(forgetPasswordButton, 5)
    .heightIs(50);
    
//    @weakify(self)
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self)
//        UIButton *button = (UIButton *)x;
//        IWTabBarViewController *nav = [[IWTabBarViewController alloc] init];
//        [AppDelegate appDelegate].window.rootViewController = nav;
        
        [self.view endEditing:YES];
        
    }];
    
//立即注册
    UIButton *registeredButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:registeredButton];
    [registeredButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [registeredButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    registeredButton.sd_layout
    .topSpaceToView(_loginButton, 5)
    .centerXIs(WIDTH/2)
    .widthIs(120)
    .heightIs(50);
    
    [[registeredButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self)
        UIViewController *vc = [NSClassFromString(@"RegisterViewController") new];
        vc.title = @"注册";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
//分割线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithWhite:0.605 alpha:0.595];
    [self.view addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self.view, margin-10)
    .rightSpaceToView(self.view, margin-10)
    .topSpaceToView(registeredButton, 35)
    .heightIs(1);
    
    
//第三方登录
    UIButton *theThirdPartyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:theThirdPartyButton];
    [theThirdPartyButton setTitle:@"-第三方登录-" forState:UIControlStateNormal];
    [theThirdPartyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    theThirdPartyButton.titleLabel.font = kMainFont;
    
    theThirdPartyButton.sd_layout
    .topSpaceToView(lineView, 5)
    .centerXIs(WIDTH/2)
    .widthIs(120)
    .heightIs(50);
    
//微信
    UIButton *wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatButton setImage:[UIImage imageNamed:@"login_icon_wechat.png"] forState:UIControlStateNormal];
    [self.view addSubview:wechatButton];
    
    wechatButton.sd_layout
    .topSpaceToView(theThirdPartyButton, 0)
    .centerXIs(WIDTH/2)
    .widthIs(40)
    .heightIs(40);
//QQ
    UIButton *QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQButton setImage:[UIImage imageNamed:@"login_icon_qq.png"] forState:UIControlStateNormal];
    [self.view addSubview:QQButton];
    
    QQButton.sd_layout
    .topEqualToView(wechatButton)
    .rightSpaceToView(wechatButton, 15)
    .widthIs(40)
    .heightIs(40);
//微博
    UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiboButton setImage:[UIImage imageNamed:@"login_icon_weibo.png"] forState:UIControlStateNormal];
    [self.view addSubview:weiboButton];
    
    weiboButton.sd_layout
    .topEqualToView(wechatButton)
    .leftSpaceToView(wechatButton, 15)
    .widthIs(40)
    .heightIs(40);
}

#pragma mark - 设置登陆按钮是否可用的信号
/**
 *  设置登陆按钮是否可用的信号
 */
- (void)setuploginButtonEnableSignal{
    // 设置用户名是否合法的信号
    // map用于改变信号返回的值，在信号中判断后，返回bool值
    RACSignal *usernameSignal = [self.phoneTestField.rac_textSignal map:^id(NSString *usernameText) {
        NSUInteger length = usernameText.length;
        if (length == kMaxPhoneNums && [Global isMobileNumber:usernameText]) {
            return @(YES);
        }
        return @(NO);
    }];
    // 设置密码是否合法的信号
    RACSignal *passwordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *passwordText) {
        NSUInteger length = passwordText.length;
        if (length >= 6 && length <= kMaxpasswordNums) {
            return @(YES);
        }
        return @(NO);
    }];
    // 绑定用户名、密码、判断结果的两个信号量，如果两个都为真，则按钮可用
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[usernameSignal, passwordSignal] reduce:^(NSNumber *isUsernameCorrect, NSNumber *isPasswordCorrect){
        if (isUsernameCorrect.boolValue && isPasswordCorrect.boolValue) {
            [self.loginButton setBackgroundColor:kTabbarHighlightedColor];
        }else{
            [self.loginButton setBackgroundColor:kButtonBgGrayColor];
        }
        return @(isUsernameCorrect.boolValue && isPasswordCorrect.boolValue);
    }];
    
    [self.phoneTestField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.phoneTestField.text.length > kMaxPhoneNums) {
            self.phoneTestField.text = [self.phoneTestField.text substringToIndex:kMaxPhoneNums];
        }
    }];
    
    [self.passwordTextField.rac_textSignal subscribeNext:^(id x) {
        
        if (self.passwordTextField.text.length > kMaxpasswordNums) {
            self.passwordTextField.text = [self.passwordTextField.text substringToIndex:kMaxpasswordNums];
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
