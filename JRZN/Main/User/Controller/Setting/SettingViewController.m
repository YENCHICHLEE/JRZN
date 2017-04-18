//
//  SettingViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/3.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "SettingViewController.h"
#import "ZGRNavigationController.h"
#import "LoginViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeTableView];
    
    
        UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        exitButton.frame = CGRectMake(20, 20, WIDTH-40, 44);
        [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];

        [exitButton setTitleColor:kTabbarNormalColor forState:UIControlStateNormal];
//        exitButton.titleLabel.font = UIFont15;
        [exitButton setBackgroundColor:kTabbarHighlightedColor];
        exitButton.layer.cornerRadius = 3;
        exitButton.layer.masksToBounds = YES;
        [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
        exitButton.cjr_acceptEventInterval = 1;

        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        [view addSubview:exitButton];
        
        _tableView.tableFooterView = view;
    
    // Do any additional setup after loading the view.
}

- (void)makeTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 1.0;
    _tableView.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:_tableView];
    
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark 设置自定义段头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kViewBackgroundColor;
    [cell.contentView addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(cell.contentView, 15)
    .widthIs(WIDTH-15)
    .heightIs(1)
    .bottomSpaceToView(cell.contentView, -0.5);
    
    //    }
    
    NSArray *titleArr = @[@"更改手机号码", @"更改登录密码", @"更多"];
    
    cell.textLabel.text = titleArr[indexPath.row];
    cell.textLabel.textColor = kBlackTitleColor;
    cell.textLabel.font = kMainFont;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *array = @[@"VerifyMobilePhoneViewController",@"ChangeLoginPasswordViewController",@"MoreViewController"];
    NSArray *titleArr = @[@"验证原手机号",@"修改密码",@"更多"];
    
    UIViewController *vc = [NSClassFromString(array[indexPath.row]) new];
    vc.title = titleArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 退出登录
- (void)exitButtonClick{

    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出登录？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    @weakify(self)
    [al showWithCompletionHandler:^(NSInteger buttonIndex) {
        DDLog(@"%ld",buttonIndex);
        
        @strongify(self)
        
        if (buttonIndex == 1) {
            LoginViewController *vc = [[LoginViewController alloc] init];
            
            ZGRNavigationController *nav = [[ZGRNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
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
