//
//  RegisterSuccessViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/7.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "RegisterSuccessViewController.h"

@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)pushHomePage:(id)sender {
    
    //通知我的界面-注册登录的
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationRegisteredSuccessRefreash object:@0 userInfo:nil];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:NotificationRegisteredSuccessRefreash name:nil object:self];
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
