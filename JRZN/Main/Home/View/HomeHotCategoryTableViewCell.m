//
//  HomeHotCategoryTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/14.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeHotCategoryTableViewCell.h"

@implementation HomeHotCategoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{

    self.projectLabel = [UILabel new];
    self.moneyLabel = [UILabel new];
    self.timeLabel = [UILabel new];
    self.earningsLabel = [UILabel new];
    
    self.projectLabel.text = @"如意礼M9（陆金所）";
    self.projectLabel.textColor = kBlackTitleColor;
    self.projectLabel.font = kMainFont;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kViewBackgroundColor;
    
    //
    UILabel *moneyTitleLabel = [UILabel new];
    moneyTitleLabel.text = @"标的总额";
    moneyTitleLabel.textColor = kGrayTitleColor;
    moneyTitleLabel.font = kDetailFont;
    moneyTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *timeTitleLabel = [UILabel new];
    timeTitleLabel.text = @"借款期限";
    timeTitleLabel.textColor = kGrayTitleColor;
    timeTitleLabel.font = kDetailFont;
    timeTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *earningsTitleLabel = [UILabel new];
    earningsTitleLabel.text = @"年化收益";
    earningsTitleLabel.textColor = kGrayTitleColor;
    earningsTitleLabel.font = kDetailFont;
    earningsTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //
    self.moneyLabel.text = @"￥1000000.00";
    self.moneyLabel.textColor = kGrayTitleColor;
    self.moneyLabel.font = kDetailFont;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.timeLabel.text = @"6个月";
    self.timeLabel.textColor = kGrayTitleColor;
    self.timeLabel.font = kDetailFont;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.earningsLabel.text = @"15.00%";
    self.earningsLabel.textColor = kRedTitleColor;
    self.earningsLabel.font = kDetailFont;
    self.earningsLabel.textAlignment = NSTextAlignmentCenter;
    
    
    NSArray *views = @[self.projectLabel, self.moneyLabel, self.timeLabel, self.earningsLabel, lineView, moneyTitleLabel, timeTitleLabel, earningsTitleLabel];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    self.projectLabel.sd_layout
    .leftSpaceToView(contentView, 27)
    .topSpaceToView(contentView, 15)
    .rightSpaceToView(contentView, 27)
    .autoHeightRatio(0);
    
    moneyTitleLabel.sd_layout
    .leftSpaceToView(contentView, 0)
    .topSpaceToView(self.projectLabel, 8)
    .widthIs(WIDTH/3)
    .autoHeightRatio(0);
    
    timeTitleLabel.sd_layout
    .leftSpaceToView(moneyTitleLabel, 0)
    .topSpaceToView(self.projectLabel, 8)
    .widthIs(WIDTH/3)
    .autoHeightRatio(0);
    
    earningsTitleLabel.sd_layout
    .leftSpaceToView(timeTitleLabel, 0)
    .topSpaceToView(self.projectLabel, 8)
    .widthIs(WIDTH/3)
    .autoHeightRatio(0);
    
    //
    self.moneyLabel.sd_layout
    .leftSpaceToView(contentView, 0)
    .topSpaceToView(moneyTitleLabel, 8)
    .widthIs(WIDTH/3)
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.moneyLabel, 0)
    .topSpaceToView(timeTitleLabel, 8)
    .widthIs(WIDTH/3)
    .autoHeightRatio(0);
    
    self.earningsLabel.sd_layout
    .leftSpaceToView(self.timeLabel, 0)
    .topSpaceToView(earningsTitleLabel, 8)
    .widthIs(WIDTH/3)
    .autoHeightRatio(0);
    
    
    
    lineView.sd_layout
    .leftSpaceToView(contentView, 15)
    .rightSpaceToView(contentView, 15)
    .heightIs(1)
    .topSpaceToView(self.moneyLabel, 15);
    
    [self setupAutoHeightWithBottomView:lineView bottomMargin:0];
    
//    [self setupAutoHeightWithBottomViewsArray:@[lineView] bottomMargin:15];
}

@end
