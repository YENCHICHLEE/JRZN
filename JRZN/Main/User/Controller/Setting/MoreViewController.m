//
//  MoreViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/8.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeTableView];
    
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
    
    return 4;
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
    
    NSArray *titleArr = @[@"关于我们", @"邀请好友", @"常见问题", @"意见反馈"];
    
    cell.textLabel.text = titleArr[indexPath.row];
    cell.textLabel.textColor = kBlackTitleColor;
    cell.textLabel.font = kMainFont;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *array = @[@"FeedbackViewController", @"FeedbackViewController", @"FeedbackViewController", @"FeedbackViewController"];
    NSArray *titleArr = @[@"关于我们", @"邀请好友", @"常见问题", @"意见反馈"];
    
    UIViewController *vc = [NSClassFromString(array[indexPath.row]) new];
    vc.title = titleArr[indexPath.row];
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
