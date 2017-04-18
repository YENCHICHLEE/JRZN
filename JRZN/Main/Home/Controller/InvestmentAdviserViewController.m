//
//  InvestmentAdviserViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/12.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "InvestmentAdviserViewController.h"

@interface InvestmentAdviserViewController ()

@end

@implementation InvestmentAdviserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)appointmentContactClick:(id)sender {
    UIViewController *vc = [NSClassFromString(@"AppointmentContactViewController") new];
    vc.title = @"预约联系";
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)riskAssessmentClick:(id)sender {
    UIViewController *vc = [NSClassFromString(@"RiskAssessmentViewController") new];
    vc.title = @"风险测评";
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
