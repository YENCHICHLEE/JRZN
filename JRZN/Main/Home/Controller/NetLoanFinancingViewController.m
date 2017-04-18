//
//  NetLoanFinancingViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "NetLoanFinancingViewController.h"
#import "FilterBaseTableViewCell.h"
#import "FilterModel.h"

@interface NetLoanFinancingViewController ()<UITableViewDataSource, UITableViewDelegate, FilterBaseTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NetLoanFinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeTableView];
    
    [self loadData];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(WIDTH/2-50, 20, 100, 30);
    [resetButton setTitle:@"重置选项" forState:UIControlStateNormal];
    
    [resetButton setTitleColor:kBlackTitleColor forState:UIControlStateNormal];
    resetButton.titleLabel.font = kDetailFont;
    [resetButton setBackgroundColor:kViewBackgroundColor];
    resetButton.layer.cornerRadius = 3;
    resetButton.layer.masksToBounds = YES;
    [resetButton addTarget:self action:@selector(resetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    resetButton.cjr_acceptEventInterval = 1;
    
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame = CGRectMake(20, 70, WIDTH-40, 44);
    [exitButton setTitle:@"筛选" forState:UIControlStateNormal];
    
    [exitButton setTitleColor:kTabbarNormalColor forState:UIControlStateNormal];
    //        exitButton.titleLabel.font = UIFont15;
    [exitButton setBackgroundColor:kTabbarHighlightedColor];
    exitButton.layer.cornerRadius = 3;
    exitButton.layer.masksToBounds = YES;
    [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    exitButton.cjr_acceptEventInterval = 1;
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
    [view addSubview:exitButton];
    [view addSubview:resetButton];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = kLineColor;
    [view addSubview:bottomView];
    
    _tableView.tableFooterView = view;
    
    // Do any additional setup after loading the view.
}

- (void)loadData{

    NSArray *categoryNameArray = @[@"资金托管",
                                   @"平台类型",
                                   @"产品期限",
                                   @"产品利率"];
    
    NSArray *categoryDetailListArray = @[@[@"不限", @"第三方存管", @"银行存管", @"无存托管"],
                                         @[@"不限", @"银行", @"风投", @"国资", @"民营", @"上市"],
                                         @[@"不限", @"一个月以内", @"1-3月标", @"4-6月标", @"7-12月标", @"12月标以上"],
                                         @[@"不限", @"8%以下", @"8%-12%", @"13%-16%", @"17%-20%", @"20%以上"]
                                         ];
    
    NSArray *categoryButtonTagArray = @[@"300", @"310", @"320", @"330"];
    
    NSMutableArray *selectButtonArray = [NSMutableArray arrayWithCapacity:0];
    if ([UserModel shareUserModelManager].netLoanFinancingArray.count) {
        
        selectButtonArray = [UserModel shareUserModelManager].netLoanFinancingArray;
    }else{
        selectButtonArray = [@[@"0", @"0", @"0", @"0"] mutableCopy];
        [UserModel shareUserModelManager].netLoanFinancingArray = selectButtonArray;
    }
    
    
    for (int i=0; i<categoryNameArray.count; i++) {
        
        FilterModel *model = [FilterModel new];
        model.categoryName = categoryNameArray[i];
        model.categoryDetailListArray = categoryDetailListArray[i];
        model.categoryButtonTag = [categoryButtonTagArray[i] integerValue];
        model.selectButton = [selectButtonArray[i] integerValue];
        
        [self.dataArray addObject:model];
        
    }
    
    [_tableView reloadData];
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
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FilterBaseTableViewCell * cell = nil;
    FilterModel * model = self.dataArray[indexPath.row];
    
    NSString * identifier = @"FilterBaseTableViewCell";
    Class mClass =  NSClassFromString(identifier);
    
    cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
        cell = [[mClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    cell.delegate = self;
    cell.model = model;
    
    /*** 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 ***/
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    /*************************************************************/
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // cell自适应设置
    FilterModel * model = self.dataArray[indexPath.row];
    
    NSString * identifier = @"FilterBaseTableViewCell";
    Class mClass =  NSClassFromString(identifier);
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:mClass contentViewWidth:[self cellContentViewWith]];
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

- (void)didSelectedFilterButton:(UIButton *)button{

    DDLog(@"%ld",button.tag);
    
    NSInteger indexPath = (button.tag - 300)/10;
    NSInteger indexPathRow = (button.tag - 300)%10;
    
    FilterModel *model = self.dataArray[indexPath];
    model.selectButton = indexPathRow;
    
    [UserModel shareUserModelManager].netLoanFinancingArray[indexPath] = @(indexPathRow);
    
    //一个cell刷新
    NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:indexPath inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath2,nil] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 重置按钮
- (void)resetButtonClick{

    for (int i=0; i<self.dataArray.count; i++) {
        FilterModel *model = self.dataArray[i];
        model.selectButton = 0;
    }
    
    [UserModel shareUserModelManager].netLoanFinancingArray = [@[@"0", @"0", @"0", @"0"] mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark - 确定筛选条件
- (void)exitButtonClick{

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
