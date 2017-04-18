//
//  OpinionColumnsViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/15.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "OpinionColumnsViewController.h"
#import "OpinionColumnsModel.h"
#import "OpinionColumnsTableViewCell.h"

@interface OpinionColumnsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITextField *_textField;
}
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation OpinionColumnsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 0;
    [self makeTableView];
    
    [self refresh];
    
    [self makeTextField];
    
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

- (void)makeTextField{
    
    _textField = [[UITextField alloc] initWithFrame:self.view.bounds];
    _textField.backgroundColor = kViewBackgroundColor;
    _textField.placeholder = @"我要评论";
    _textField.font = kMainFont;
    _textField.clearButtonMode = YES;
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySend;
    [self.view addSubview:_textField];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
    logoImageView.image = [UIImage imageNamed:@"icon_tiezi"];
    
    UIView *logoImageViewBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [logoImageViewBgView addSubview:logoImageView];
    
    _textField.leftView = logoImageViewBgView;
    //以上是无法显示图片的需要设置mode
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.returnKeyType =UIReturnKeyDone;
    
    _textField.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(44);
    
    UIView *lineView = [UIView new];
    [_textField addSubview:lineView];
    lineView.backgroundColor = kLineColor;
    
    lineView.sd_layout
    .leftSpaceToView(_textField, 0)
    .rightSpaceToView(_textField, 0)
    .topSpaceToView(_textField, 0)
    .heightIs(0.5);
}

- (void)makeTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OpinionColumnsTableViewCell * cell = nil;
    //    HomeModel * homeModel = self.dataArray[indexPath.row];
    OpinionColumnsModel * model;
    
    NSString * identifier = @"OpinionColumnsTableViewCell";
    Class mClass =  NSClassFromString(identifier);
    
    cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[mClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.model = model;
    
    /*** 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 ***/
    
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    /*************************************************************/
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // cell自适应设置
    //    HomeModel * homeModel = self.dataArray[indexPath.row];
    OpinionColumnsModel * model;
    
    NSString * identifier = @"OpinionColumnsTableViewCell";
    Class mClass =  NSClassFromString(identifier);
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:mClass contentViewWidth:[self cellContentViewWith]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
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
