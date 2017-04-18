//
//  UserCollectionViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "UserCollectionViewController.h"
#import "CollectionPlatformTableViewController.h"
#import "CollectProductTableViewController.h"

@interface UserCollectionViewController ()
{
    UIView *_popView;//段头移动线条
    int isSelect;//移动线条控制
    
    UIView *topView;//顶部选项卡
}

/**
 *  平台
 */
@property (nonatomic, strong) CollectionPlatformTableViewController *platformTableView;
/**
 *  产品
 */
@property (nonatomic, strong) CollectProductTableViewController *productTableView;
@end

@implementation UserCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeTopView];
    
    [self makePlatformTableView];
    
    [self makeProductTableView];
    
    // Do any additional setup after loading the view.
}

- (void)makeTopView{

    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    
    NSArray *titleArr = @[@"平台", @"产品"];
    long count = titleArr.count;
    
    [titleArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [topView addSubview:button];
        
        [button setTitle:titleArr[idx] forState:UIControlStateNormal];
        [button setTitleColor:kGrayTitleColor forState:UIControlStateNormal];
        button.titleLabel.font = kMainFont;
        
        button.frame = CGRectMake(idx%count*WIDTH/count, 0, WIDTH/count, 44);
        
        button.tag = 250+idx;
        [button addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
    _popView.backgroundColor = kTabbarHighlightedColor;
    _popView.x = isSelect * WIDTH/count;
    
    [topView addSubview:lineView1];
    [topView addSubview:lineView2];
    [topView addSubview:_popView];
    
    topView.backgroundColor = kTabbarNormalColor;
    
    [self.view addSubview:topView];
}

- (void)makePlatformTableView{//平台
    
    _platformTableView = [[CollectionPlatformTableViewController alloc] init];
    [self addChildViewController:_platformTableView];
    [self.view addSubview:_platformTableView.view];
    
    _platformTableView.view.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(topView, 0)
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
}

- (void)makeProductTableView{//产品
    
    _productTableView = [[CollectionPlatformTableViewController alloc] init];
    [self addChildViewController:_productTableView];
    [self.view addSubview:_productTableView.view];
    _productTableView.view.hidden = YES;
    
    _productTableView.view.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(topView, 0)
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
}

- (void)topButtonClick:(UIButton *)button{
    for (int i=0; i<2; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:250+i];
        [btn setTitleColor:kGrayTitleColor forState:UIControlStateNormal];
    }
    
    [button setTitleColor:kTabbarHighlightedColor forState:UIControlStateNormal];
    
    _popView.x = (button.tag - 250) * WIDTH/2;
    
    isSelect = (int)(button.tag - 250);
    
    if (isSelect == 0) {
        _platformTableView.view.hidden = NO;
        _productTableView.view.hidden = YES;
    }else{
        _platformTableView.view.hidden = YES;
        _productTableView.view.hidden = NO;
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
