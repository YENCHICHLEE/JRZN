//
//  AppointmentContactViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/12.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "AppointmentContactViewController.h"
#import "DatePickerView.h"
@interface AppointmentContactViewController ()<DatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;//手机号
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;//邮箱
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;//时间
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;//备注

@end

@implementation AppointmentContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dateTimeLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.dateTimeLabel addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)tapClick{

    [self.view endEditing:YES];
    DatePickerView *date = [[DatePickerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    date.delegate = self;
    [self.view addSubview:date];
}

#pragma mark - DatePickerViewDelegate
- (void)datePickerSelectorIndixString:(NSString *)str{

    DDLog(@"%@",str);
    self.dateTimeLabel.text = str;
    self.dateTimeLabel.textColor = rgb(0, 0, 0);
}
- (IBAction)submitClick:(id)sender {
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
