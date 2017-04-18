//
//  InformationViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/11.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "InformationViewController.h"

#import "InformationTableViewController.h"
#import "SpecialTableViewController.h"

@interface InformationViewController ()<UIScrollViewDelegate>
{
    UISegmentedControl *homeSegmentedControl;//开关
}

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) InformationTableViewController *informationTableView;//咨询

@property (nonatomic, strong) SpecialTableViewController *specialTableView;//专栏

@end

@implementation InformationViewController

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
    self.title = @"资讯";
    
    [self makeNav];
    
    [self makeInformationTableView];
    
    [self makeSpecialTableView];
    
    // Do any additional setup after loading the view.
}

- (void)makeNav{

    //开关
    homeSegmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"资讯",@"专栏"]];
    homeSegmentedControl.frame=CGRectMake(0, 0, 250, 30);
    //设置一个默认的选中
    homeSegmentedControl.selectedSegmentIndex = 0;
    //添加方法
    [homeSegmentedControl addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    //设置背景色
    //    homeSegmentedControl.backgroundColor=[UIColor redColor];
    [homeSegmentedControl setTintColor:[UIColor whiteColor]];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:kBlackTitleColor,UITextAttributeTextColor,[UIFont systemFontOfSize:13],UITextAttributeFont ,nil];
    [homeSegmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    self.navigationItem.titleView=homeSegmentedControl;
}

- (void)makeSpecialTableView{//专栏
    
    _specialTableView = [[InformationTableViewController alloc] init];
    [self addChildViewController:_specialTableView];
    [self.view addSubview:_specialTableView.view];
    _specialTableView.view.hidden = YES;
    
    _specialTableView.view.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .widthIs(WIDTH);

}

- (void)makeInformationTableView{//咨询

    _informationTableView = [[InformationTableViewController alloc] init];
    [self addChildViewController:_informationTableView];
    [self.view addSubview:_informationTableView.view];
    
    _informationTableView.view.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .widthIs(WIDTH);
}



#pragma mark - UISegmentedControl
- (void)segClick:(UISegmentedControl *)segmentedControl{

    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
        {//资讯
            _informationTableView.view.hidden = NO;
            _specialTableView.view.hidden = YES;
        }
            break;
        case 1:
        {//专栏
            _informationTableView.view.hidden = YES;
            _specialTableView.view.hidden = NO;
        }
            break;
            
        default:
            break;
    }
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
