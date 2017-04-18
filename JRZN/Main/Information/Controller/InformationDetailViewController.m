//
//  InformationDetailViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/20.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "InformationDetailViewController.h"

@interface InformationDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollview;

@end

@implementation InformationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻资讯";
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"分享.png" highIcon:@"分享.png" target:self action:@selector(shareClick)];
    
    [self makeScrollview];
    
    [self makeUI];
    
    // Do any additional setup after loading the view.
}

- (void)makeScrollview{
    
    _scrollview = [UIScrollView new];
    [self.view addSubview:_scrollview];
    
//    _scrollview.pagingEnabled = YES;
    _scrollview.contentSize = CGSizeMake(WIDTH, 1000);
    _scrollview.showsHorizontalScrollIndicator = FALSE;
    
    _scrollview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)makeUI{

    UILabel *informationTitleLabel = [UILabel new];//标题
    UILabel *sourceLabel = [UILabel new];//来源
    UILabel *numberLabel = [UILabel new];//数量
    UILabel *timeLabel = [UILabel new];//时间
    UIView *lineView = [UIView new];//灰色背景
    UILabel *abstractLabel = [UILabel new];//摘要
    UIImageView *informationImageView = [UIImageView new];//图片
    
    
    NSArray *views = @[informationTitleLabel, sourceLabel, numberLabel, timeLabel, lineView, informationImageView];
    
    [_scrollview sd_addSubviews:views];
    
    [lineView addSubview:abstractLabel];
    
    informationTitleLabel.text = @"互联网金融领域最值得关注的机会与风险";
    informationTitleLabel.textColor = kBlackTitleColor;
    informationTitleLabel.font = UIFont20;
    informationTitleLabel.numberOfLines = 0;
    
    
    sourceLabel.text = @"来源：今融指南";
    sourceLabel.textColor = kGrayTitleColor;
    sourceLabel.font = kDetailFont;
    
    
    numberLabel.text = @"2333";
    numberLabel.textColor = kGrayTitleColor;
    numberLabel.font = kDetailFont;
    
    
    timeLabel.text = @"2016-05-20";
    timeLabel.textColor = kGrayTitleColor;
    timeLabel.font = kDetailFont;
    
    
    abstractLabel.text = @"【摘要】从被公认为互联网金融元年的2013年开始，经过伴随着创新牛市和改革牛市飞速发展的2014年，再到牛市泡沫逐步退去...";
    abstractLabel.textColor = kBlackTitleColor;
    abstractLabel.font = kMainFont;
    abstractLabel.numberOfLines = 0;
    
    lineView.backgroundColor = [UIColor colorWithRed:0.898 green:0.902 blue:0.906 alpha:1.000];
    
    informationImageView.image = [UIImage imageNamed:@"banner"];
    
    UIScrollView *scrollview = self.scrollview;
    CGFloat margin = 10;
    
    informationTitleLabel.sd_layout
    .leftSpaceToView(scrollview, margin*2)
    .topSpaceToView(scrollview, margin*2)
    .rightSpaceToView(scrollview, margin*2)
    .autoHeightRatio(0);
    
    sourceLabel.sd_layout
    .leftEqualToView(informationTitleLabel)
    .widthIs(120)
    .topSpaceToView(informationTitleLabel, margin)
    .heightIs(20);
    
    
    numberLabel.sd_layout
    .centerXIs(WIDTH/2)
    .topEqualToView(sourceLabel)
    .widthIs(60)
    .heightIs(20);
    
    timeLabel.sd_layout
    .rightEqualToView(informationTitleLabel)
    .topEqualToView(sourceLabel)
    .heightIs(20);
    
    [timeLabel setSingleLineAutoResizeWithMaxWidth:0];
    
    lineView.sd_layout
    .leftSpaceToView(scrollview, margin)
    .rightSpaceToView(scrollview, margin)
    .topSpaceToView(sourceLabel, 8)
    .heightIs(100);
    
    abstractLabel.sd_layout
    .leftSpaceToView(lineView, margin)
    .topSpaceToView(lineView, margin)
    .rightSpaceToView(lineView, margin)
    .autoHeightRatio(0);
    
    [lineView setupAutoHeightWithBottomView:abstractLabel bottomMargin:10];
    
    informationImageView.sd_layout
    .leftSpaceToView(scrollview, 15)
    .rightSpaceToView(scrollview, 15)
    .topSpaceToView(lineView, 15)
    .heightIs(210);
    
}

#pragma mark - 分享
- (void)shareClick{

    UIViewController *vc = [NSClassFromString(@"OpinionColumnsViewController") new];
    vc.title = @"观点专栏";
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
