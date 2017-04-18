//
//  VerifyNewMobilePhoneViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/8.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "VerifyNewMobilePhoneViewController.h"
#import "VerificationButton.h"
#import "SettingViewController.h"

@interface VerifyNewMobilePhoneViewController ()
@property (weak, nonatomic) IBOutlet UIView *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *VerifyTextField;
@property (weak, nonatomic) IBOutlet VerificationButton *VerifyButton;
@property (weak, nonatomic) IBOutlet UIButton *determineButton;

@end

@implementation VerifyNewMobilePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)determineClick:(id)sender {
    
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[SettingViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
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
