//
//  EmailViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/12.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 右边按钮
    UIButton* rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:kTabbarNormalColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = UIFont15;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.cjr_acceptEventInterval = 1;
    rightButton.frame = CGRectMake(0, 0, 40, 30);
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
    if ([UserModel shareUserModelManager].userEmail.length > 0) {
        self.emailTextField.text = [UserModel shareUserModelManager].userEmail;
    }
    
    [self.emailTextField becomeFirstResponder];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)rightButtonClick{
    
    [UserModel shareUserModelManager].userEmail = self.emailTextField.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
