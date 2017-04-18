//
//  UserMenuCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/3.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "UserMenuCell.h"

@implementation UserMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{

    UIView *topLineView = [UIView new];
    topLineView.backgroundColor = kViewBackgroundColor;
    
    UIView *bottomLineView = [UIView new];
    bottomLineView.backgroundColor = kViewBackgroundColor;
    
    UIView *lineOneView = [UIView new];
    lineOneView.backgroundColor = kViewBackgroundColor;
    
    UIView *lineTwoView = [UIView new];
    lineTwoView.backgroundColor = kViewBackgroundColor;
    
    //我的收藏
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.titleLabel.font = kMainFont;
    [collectButton setImage:[UIImage imageNamed:@"icon_shoucang.png"] forState:UIControlStateNormal];
    collectButton.tag = 200;
    [collectButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *collectLabel = [UILabel new];
    collectLabel.text = @"我的收藏";
    collectLabel.textColor = kBlackTitleColor;
    collectLabel.font = kMainFont;
    collectLabel.textAlignment = NSTextAlignmentCenter;
    
    //我的风险评测
    UIButton *assessmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    assessmentButton.titleLabel.font = kMainFont;
    [assessmentButton setImage:[UIImage imageNamed:@"icon_fengxianceping.png"] forState:UIControlStateNormal];
    assessmentButton.tag = 201;
    [assessmentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *assessmentLabel = [UILabel new];
    assessmentLabel.text = @"我的风险评测";
    assessmentLabel.textColor = kBlackTitleColor;
    assessmentLabel.font = kMainFont;
    assessmentLabel.textAlignment = NSTextAlignmentCenter;
    
    //我的预约
    UIButton *appointmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    appointmentButton.titleLabel.font = kMainFont;
    [appointmentButton setImage:[UIImage imageNamed:@"icon_yuyue.png"] forState:UIControlStateNormal];
    appointmentButton.tag = 202;
    [appointmentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *appointmentLabel = [UILabel new];
    appointmentLabel.text = @"我的预约";
    appointmentLabel.textColor = kBlackTitleColor;
    appointmentLabel.font = kMainFont;
    appointmentLabel.textAlignment = NSTextAlignmentCenter;
    
    //我的帖子
    UIButton *BBSButton = [UIButton buttonWithType:UIButtonTypeCustom];
    BBSButton.titleLabel.font = kMainFont;
    [BBSButton setImage:[UIImage imageNamed:@"icon_tiezi.png"] forState:UIControlStateNormal];
    BBSButton.tag = 203;
    [BBSButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *BBSLabel = [UILabel new];
    BBSLabel.text = @"我的帖子";
    BBSLabel.textColor = kBlackTitleColor;
    BBSLabel.font = kMainFont;
    BBSLabel.textAlignment = NSTextAlignmentCenter;
    
    
    NSArray *views = @[topLineView, lineOneView, lineTwoView, bottomLineView, collectButton, collectLabel, assessmentButton, assessmentLabel, appointmentButton, appointmentLabel, BBSButton, BBSLabel];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    topLineView.sd_layout
    .leftSpaceToView(contentView, 0)
    .topSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .heightIs(8);
    
    lineOneView.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(topLineView, 85)
    .heightIs(1);
    
    lineTwoView.sd_layout
    .centerXIs(WIDTH/2)
    .topSpaceToView(topLineView, 0)
    .widthIs(1)
    .heightIs(170);
    
    bottomLineView.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(lineTwoView, 0)
    .heightIs(8);
    
    collectButton.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(lineTwoView, 0)
    .topSpaceToView(topLineView, 0)
    .heightIs(60);
    
    collectLabel.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightEqualToView(collectButton)
    .topSpaceToView(collectButton, -5)
    .heightIs(20);
    
    assessmentButton.sd_layout
    .leftSpaceToView(lineTwoView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(topLineView, 0)
    .heightIs(60);
    
    assessmentLabel.sd_layout
    .leftSpaceToView(lineTwoView, 0)
    .rightEqualToView(assessmentButton)
    .topSpaceToView(assessmentButton, -5)
    .heightIs(20);
    
    appointmentButton.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(lineTwoView, 0)
    .topSpaceToView(lineOneView, 0)
    .heightIs(60);
    
    appointmentLabel.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightEqualToView(appointmentButton)
    .topSpaceToView(appointmentButton, -5)
    .heightIs(20);
    
    BBSButton.sd_layout
    .leftSpaceToView(lineTwoView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(lineOneView, 0)
    .heightIs(60);
    
    BBSLabel.sd_layout
    .leftSpaceToView(lineTwoView, 0)
    .rightEqualToView(BBSButton)
    .topSpaceToView(BBSButton, -5)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomView:bottomLineView bottomMargin:0];
}

- (void)buttonClick:(UIButton *)button{

    if ([self.delegate respondsToSelector:@selector(didSelectedMenu:)]) {
        [self.delegate didSelectedMenu:button];
    }
}

@end
