//
//  HomeViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/11.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBaseTableViewCell.h"
#import "HomeModel.h"


@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, HomeBaseTableViewCellDelegate>
{
    UIView *_popView;//段头移动线条
    int isSelect;//移动线条控制
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (id child in self.navigationController.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isSelect = 0;
    _page = 0;
    
    self.navigationItem.title = @"今融指南";
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_dh.png" highIcon:@"icon_dh.png" target:self action:@selector(callPhoneClick)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_ss.png" highIcon:@"icon_ss.png" target:self action:@selector(searchClick)];
    
    [self makeTableView];
    
    [self refresh];

    // Do any additional setup after loading the view.
}

- (void)refresh{

    __weak typeof(self) __weakSelf = self;
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _page = 0;
        [__weakSelf loadData];
        [__weakSelf.tableView.mj_header endRefreshing];
        [__weakSelf.tableView.mj_footer endRefreshing];
    }];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _page ++;
        [__weakSelf loadData];
        [__weakSelf.tableView.mj_header endRefreshing];
        [__weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadData{

    NSArray *array = @[@{@"t":[Global getTimeStamp]}];
    
    NSDictionary *dic = @{
                          @"t":[Global getTimeStamp],//时间戳
                          @"sign":[Global getSign:array]//签名
                          };
    
    
}

- (void)makeTableView{

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark 分段
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 5;
    }else{
    
        return 10;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeBaseTableViewCell * cell = nil;
//    HomeModel * homeModel = self.dataArray[indexPath.row];
    HomeModel * homeModel;
    
    NSString * identifier = [HomeBaseTableViewCell cellIdentifierForRow:indexPath];
    Class mClass =  NSClassFromString(identifier);
    
    cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[mClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.delegate = self;
    cell.homeModel = homeModel;
    
    /*** 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 ***/
    
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    /*************************************************************/
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        UIViewController *vc = [NSClassFromString(@"TextWebViewController") new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // cell自适应设置
//    HomeModel * homeModel = self.dataArray[indexPath.row];
    HomeModel * homeModel;
    
    NSString * identifier = [HomeBaseTableViewCell cellIdentifierForRow:indexPath];
    Class mClass =  NSClassFromString(identifier);
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self.tableView cellHeightForIndexPath:indexPath model:homeModel keyPath:@"homeModel" cellClass:mClass contentViewWidth:[self cellContentViewWith]];
    
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

#pragma mark 当设置了自定义段头后，直接设置的段头文字就无效了
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    
    NSArray *titleArr = @[@"网贷理财", @"宝宝理财", @"基金理财"];
    
    [titleArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:button];
        
        [button setTitle:titleArr[idx] forState:UIControlStateNormal];
        [button setTitleColor:kGrayTitleColor forState:UIControlStateNormal];
        button.titleLabel.font = kMainFont;
        
        button.frame = CGRectMake(idx%3*WIDTH/3, 0, WIDTH/3, 44);
        
        button.tag = 220+idx;
        [button addTarget:self action:@selector(hotButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (isSelect == idx) {
            
            [button setTitleColor:kTabbarHighlightedColor forState:UIControlStateNormal];
        }
        
    }];
    
    //阴影线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    lineView1.backgroundColor = kViewBackgroundColor;
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44-0.5, WIDTH, 1)];
    lineView2.backgroundColor = kViewBackgroundColor;
    
    _popView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, WIDTH/3, 1)];
    _popView.backgroundColor = kBlackTitleColor;
    _popView.x = isSelect * WIDTH/3;
    
    [view addSubview:lineView1];
    [view addSubview:lineView2];
    [view addSubview:_popView];
    
    view.backgroundColor = kTabbarNormalColor;
    
    return view;
}
#pragma mark 设置自定义段头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }else{
    
        return 0;
    }
}

#pragma mark - HomeBaseTableViewCellDelegate

#pragma mark - 轮播图代理
- (void)didSelectedBanner:(NSInteger)index{

    DDLog(@"----%ld",(long)index);
    UIViewController *vc = [NSClassFromString(@"InformationDetailViewController") new];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didSelectedMenuOne:(UIButton *)button{

    DDLog(@"---%ld",button.tag-100);
    
    NSArray *vcArr = @[@"RiskAssessmentViewController", @"FinancialSupermarketViewController", @"InvestmentAdviserViewController", @"ResearchCenterViewController"];
    NSArray *titleArr = @[@"风险测评", @"金融超市", @"投资顾问", @"研究中心"];
    
    UIViewController *vc = [NSClassFromString(vcArr[button.tag - 100]) new];
    vc.title = titleArr[button.tag - 100];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectedMenuTwo:(UIButton *)button{
    
    DDLog(@"---%ld",(long)button.tag);
    
    NSArray *vcArr = @[@"FinancialSupermarketViewController", @"FinancialSupermarketViewController", @"FinancialSupermarketViewController", @"RiskAssessmentViewController", @"InformationViewController", @"InformationDetailViewController"];
    NSArray *titleArr = @[@"网贷理财", @"基金理财", @"宝宝理财", @"理财工具", @"今融点评", @"关于我们"];
    
    if (button.tag == 204) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationRegisteredSuccessRefreash object:@1 userInfo:nil];
        return;
    }
    
    UIViewController *vc = [NSClassFromString(vcArr[button.tag - 200]) new];
    vc.title = titleArr[button.tag - 200];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 头条新闻
- (void)didSelectedHomeHeadlines:(NSInteger)index{

    DDLog(@"%ld",(long)index);
    UIViewController *vc = [NSClassFromString(@"InformationDetailViewController") new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 热门产品
- (void)hotButtonClick:(UIButton *)button{

    DDLog(@"---%ld",(long)button.tag);
    for (int i=0; i<3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:220+i];
        [btn setTitleColor:kGrayTitleColor forState:UIControlStateNormal];
    }
    
    [button setTitleColor:kTabbarHighlightedColor forState:UIControlStateNormal];
    
    _popView.x = (button.tag - 220) * WIDTH/3;
    
    isSelect = (int)(button.tag - 220);
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark 拨打电话
- (void)callPhoneClick{

    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"拨打400电话？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    [al showWithCompletionHandler:^(NSInteger buttonIndex) {
        DDLog(@"%ld",(long)buttonIndex);
    }];
     
    
}
#pragma mark 搜索
- (void)searchClick{

//    UIViewController *vc = [NSClassFromString(@"HomeSearchViewController") new];
//    vc.title = @"搜索";
//    [self.navigationController pushViewController:vc animated:YES];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
//                                       defaultContent:@"测试一下"
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"ShareSDK"
//                                                  url:@"http://www.mob.com"
//                                          description:@"这是一条测试信息"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    //要分享的列表
//    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeQQ,ShareTypeWeixiSession,ShareTypeWeixiTimeline,nil];
//    
//    //创建iPad弹出菜单容器,详见第六步
//    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
//    
//    //弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:shareList
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
//                                }
//                            }];
    
}

- (void)hudClick{

    
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
