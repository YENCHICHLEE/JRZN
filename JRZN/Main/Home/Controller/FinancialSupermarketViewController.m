//
//  FinancialSupermarketViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "FinancialSupermarketViewController.h"
#import "HomeBaseTableViewCell.h"
#import "HomeModel.h"
#import "BabyFinanceTableViewCell.h"

@interface FinancialSupermarketViewController ()<UITableViewDataSource, UITableViewDelegate, HomeBaseTableViewCellDelegate>
{
    UIView *_popView;//段头移动线条
    int isSelect;//移动线条控制
    UISegmentedControl *financialSegmentedControl;//开关
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FinancialSupermarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    
    [self makeTableView];
    
    [self refresh];
    
    //开关
    financialSegmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"网贷理财",@"宝宝理财", @"基金理财"]];
    financialSegmentedControl.frame=CGRectMake(30, 6, WIDTH-60, 30);
    //设置一个默认的选中
    financialSegmentedControl.selectedSegmentIndex = 0;
    
    if ([self.title isEqualToString:@"宝宝理财"]) {
        financialSegmentedControl.selectedSegmentIndex = 1;
    }
    
    if ([self.title isEqualToString:@"基金理财"]) {
        financialSegmentedControl.selectedSegmentIndex = 2;
    }
    
    //添加方法
    [financialSegmentedControl addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    //设置背景色
//        homeSegmentedControl.backgroundColor=[UIColor redColor];
    [financialSegmentedControl setTintColor:kBlackTitleColor];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:kTabbarNormalColor,UITextAttributeTextColor,[UIFont systemFontOfSize:13],UITextAttributeFont ,nil];
    [financialSegmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    [view addSubview:financialSegmentedControl];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = kLineColor;
    [view addSubview:bottomView];
    
    bottomView.sd_layout
    .leftSpaceToView(view, 0)
    .rightSpaceToView(view, 0)
    .bottomSpaceToView(view, 0)
    .heightIs(8);
    
    _tableView.tableHeaderView = view;
    
    // Do any additional setup after loading the view.
}

- (void)refresh{
    
    __weak typeof(self) __weakSelf = self;
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _page = 0;
        //        [weakSelf loadData];
        [__weakSelf.tableView.mj_header endRefreshing];
        [__weakSelf.tableView.mj_footer endRefreshing];
    }];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _page ++;
        //        [weakSelf loadData];
        [__weakSelf.tableView.mj_header endRefreshing];
        [__weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)makeTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (financialSegmentedControl.selectedSegmentIndex == 0) {
        HomeBaseTableViewCell * cell = nil;
        //    HomeModel * homeModel = self.dataArray[indexPath.row];
        HomeModel * homeModel;
        
        NSString * identifier = @"HomeHotCategoryTableViewCell";
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
    }else{
        BabyFinanceTableViewCell * cell = nil;
        //    HomeModel * homeModel = self.dataArray[indexPath.row];
        HomeModel * homeModel;
        
        NSString * identifier = @"BabyFinanceTableViewCell";
        Class mClass =  NSClassFromString(identifier);
        
        cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[mClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
//        cell.delegate = self;
//        cell.homeModel = homeModel;
        
        /*** 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 ***/
        
        cell.sd_tableView = tableView;
        cell.sd_indexPath = indexPath;
        
        /*************************************************************/
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *vc = [NSClassFromString(@"MessageDetailViewController") new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // cell自适应设置
    //    HomeModel * homeModel = self.dataArray[indexPath.row];
    HomeModel * homeModel;
    
    NSString * identifier = (financialSegmentedControl.selectedSegmentIndex == 0)? @"HomeHotCategoryTableViewCell":@"BabyFinanceTableViewCell";
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
    
    NSArray *titleArr = @[@"默认", @"收益率↑", @"期限↑", @"筛选△"];
    long count = titleArr.count;
    
    [titleArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:button];
        
        [button setTitle:titleArr[idx] forState:UIControlStateNormal];
        [button setTitleColor:kBlackTitleColor forState:UIControlStateNormal];
        button.titleLabel.font = kMainFont;
        
        button.frame = CGRectMake(idx%count*WIDTH/count, 0, WIDTH/count, 44);
        
        button.tag = 230+idx;
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
    
    _popView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, WIDTH/count, 1)];
    _popView.backgroundColor = kBlackTitleColor;
    _popView.x = isSelect * WIDTH/count;
    
    [view addSubview:lineView1];
    [view addSubview:lineView2];
    [view addSubview:_popView];
    
    view.backgroundColor = kTabbarNormalColor;
    
    return view;
}
#pragma mark 设置自定义段头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

#pragma mark - 筛选条件
- (void)hotButtonClick:(UIButton *)button{
    
    DDLog(@"---%ld",(long)button.tag);
    for (int i=0; i<4; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:230+i];
        [btn setTitleColor:kBlackTitleColor forState:UIControlStateNormal];
    }
    
    [button setTitleColor:kTabbarHighlightedColor forState:UIControlStateNormal];
    
    _popView.x = (button.tag - 230) * WIDTH/4;
    
    isSelect = (int)(button.tag - 230);
    
    if (button.tag == 233) {
        
        NSArray *controllerArray = @[@"NetLoanFinancingViewController", @"BabyFinanceViewController", @""];
        NSArray *controllerTitleArray = @[@"网贷理财", @"宝宝理财", @"基金理财"];
        
        if (financialSegmentedControl.selectedSegmentIndex == 2) {
            return;
        }
        
        UIViewController *vc = [NSClassFromString(controllerArray[financialSegmentedControl.selectedSegmentIndex]) new];
        vc.title = controllerTitleArray[financialSegmentedControl.selectedSegmentIndex];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - UISegmentedControl
- (void)segClick:(UISegmentedControl *)segmentedControl{

    [_tableView reloadData];
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
