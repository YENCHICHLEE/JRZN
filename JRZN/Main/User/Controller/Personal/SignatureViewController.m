//
//  SignatureViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/8.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "SignatureViewController.h"
#import "IQTextView.h"

@interface SignatureViewController ()
@property (weak, nonatomic) IBOutlet IQTextView *SignatureTextView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation SignatureViewController

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
    
    self.SignatureTextView.placeholder = @"请点击添加个性签名";
    
    if ([UserModel shareUserModelManager].userSignature.length > 0) {
        self.SignatureTextView.text = [UserModel shareUserModelManager].userSignature;
    }
    
    // 设置是否合法的信号
    RACSignal *signatureSignal = [self.SignatureTextView.rac_textSignal map:^id(NSString *signatureText) {
        NSUInteger length = signatureText.length;
        self.numberLabel.text = [NSString stringWithFormat:@"%ld/%d",length,kMaxSigningNums+1];
        if (length > 0 && length <= kMaxSigningNums) {
            return @(YES);
        }
        return @(NO);
    }];
    
    [self.SignatureTextView becomeFirstResponder];
    
    RAC(rightButton, enabled) = [RACSignal combineLatest:@[signatureSignal] reduce:^(NSNumber *isSignatureCorrect){

        return @(isSignatureCorrect.boolValue);
    }];
    
    [self.SignatureTextView.rac_textSignal subscribeNext:^(id x) {
        
        if (self.SignatureTextView.text.length > kMaxSigningNums) {
            self.SignatureTextView.text = [self.SignatureTextView.text substringToIndex:kMaxSigningNums];
        }
    }];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)rightButtonClick{
    
    [UserModel shareUserModelManager].userSignature = self.SignatureTextView.text;
    
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
