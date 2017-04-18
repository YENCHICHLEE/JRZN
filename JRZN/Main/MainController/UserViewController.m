//
//  UserViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/11.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "UserViewController.h"
#import "UserBaseTableViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "LoginViewController.h"
#import "ZGRNavigationController.h"

@interface UserViewController ()<UITableViewDataSource, UITableViewDelegate, UserBaseTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    [self makeTableView];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"邮件.png" highIcon:@"邮件.png" target:self action:@selector(messageCenterClick)];
    
//    @weakify(self)
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NotificationHeaderIMGRefreash object:nil] subscribeNext:^(id x) {
//        DDLog(@"更新个人信息");
//        @strongify(self)
//        
//        [self.tableView updateLayoutWithCellContentView:self.view];
//        [self.tableView updateLayout];
//        //一个cell刷新
////        [self.tableView.sd_tableView reloadData];
////        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
////        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//    }];
    
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
    
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(-64, 0, 0, 0));
}

#pragma mark 设置自定义段头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserBaseTableViewCell * cell = nil;
    UserModel *userModel = [UserModel shareUserModelManager];
    
    NSString * identifier = [UserBaseTableViewCell cellIdentifierForRow:indexPath];
    Class mClass =  NSClassFromString(identifier);
    
    cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[mClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.delegate = self;
    cell.model = userModel;
    
    /*** 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 ***/
    
//    cell.sd_tableView = tableView;
//    cell.sd_indexPath = indexPath;
//    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    /*************************************************************/
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 2) {
        UIViewController *vc = [NSClassFromString(@"SettingViewController") new];
        vc.title = @"设置";
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * identifier = [UserBaseTableViewCell cellIdentifierForRow:indexPath];
    Class mClass =  NSClassFromString(identifier);
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self.tableView cellHeightForIndexPath:indexPath model:nil keyPath:nil cellClass:mClass contentViewWidth:[self cellContentViewWith]];
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIColor * color = kBlackTitleColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > -64) {
        CGFloat alpha = MIN(1, 1 - (( - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark - 消息中心
- (void)messageCenterClick{

    UIViewController *vc = [NSClassFromString(@"MessageDetailViewController") new];
    vc.title = @"消息详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 个人资料
- (void)didSelectedHeader{
    
    UIViewController *vc = [NSClassFromString(@"PersonalViewController") new];
    vc.title = @"个人资料";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 我的收藏-风险评测-预约-帖子
- (void)didSelectedMenu:(UIButton *)button{

    NSArray *array = @[@"我的收藏",@"我的风险评测",@"我的预约",@"我的帖子"];
    NSArray *controllerStr = @[@"UserCollectionViewController", @"UserRiskAssessmentViewController", @"UserAppointmentViewController", @"MessageDetailViewController"];
    
    UIViewController *vc = [NSClassFromString(controllerStr[button.tag - 200]) new];
    vc.title = array[button.tag - 200];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (id child in self.navigationController.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.tableView reloadData];
    
//    //一个cell刷新
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"nav.png"]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav.png"] forBarMetrics:UIBarMetricsDefault];
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
