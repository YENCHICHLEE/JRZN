//
//  HomeSearchViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/1.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeSearchViewController.h"

@interface HomeSearchViewController ()<UISearchBarDelegate>
/**
 *  搜索
 */
@property (nonatomic, strong) UISearchBar *searchBar;;
@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeSearch];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_ss.png" highIcon:@"icon_ss.png" target:self action:@selector(searchClick)];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 搜索按钮
- (void)searchClick{

    
}

#pragma mark Search
- (void)makeSearch{
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    _searchBar.delegate=self;
    _searchBar.placeholder = @"请输入关键词搜索";
    
    //    _searchBar.layer.cornerRadius = 15;
    //    _searchBar.layer.masksToBounds = YES;
    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //    view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = _searchBar;
    
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"search_bg_1.png"]];
    
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
