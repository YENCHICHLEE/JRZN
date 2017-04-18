//
//  BabyFinanceTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/14.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "BabyFinanceTableViewCell.h"

@implementation BabyFinanceTableViewCell

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
    self.withdrawalSpeedLabel = [UILabel new];
    self.earningsLabel = [UILabel new];
    
    self.projectLabel.text = @"余额宝";
    self.projectLabel.textColor = kBlackTitleColor;
    self.projectLabel.font = kMainFont;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kViewBackgroundColor;
    
    //
    UILabel *moneyTitleLabel = [UILabel new];
    moneyTitleLabel.text = @"万份收益";
    moneyTitleLabel.textColor = kGrayTitleColor;
    moneyTitleLabel.font = kDetailFont;
    moneyTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *timeTitleLabel = [UILabel new];
    timeTitleLabel.text = @"7日年化利率";
    timeTitleLabel.textColor = kGrayTitleColor;
    timeTitleLabel.font = kDetailFont;
    timeTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *earningsTitleLabel = [UILabel new];
    earningsTitleLabel.text = @"提现速度";
    earningsTitleLabel.textColor = kGrayTitleColor;
    earningsTitleLabel.font = kDetailFont;
    earningsTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //
    self.moneyLabel.text = @"0.66元";
    self.moneyLabel.textColor = kRedTitleColor;
    self.moneyLabel.font = kDetailFont;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.earningsLabel.text = @"2.44%";
    self.earningsLabel.textColor = kRedTitleColor;
    self.earningsLabel.font = kDetailFont;
    self.earningsLabel.textAlignment = NSTextAlignmentCenter;
    
    self.withdrawalSpeedLabel.text = @"实时";
    self.withdrawalSpeedLabel.textColor = kBlackTitleColor;
    self.withdrawalSpeedLabel.font = kDetailFont;
    self.withdrawalSpeedLabel.textAlignment = NSTextAlignmentCenter;
    
    
    NSArray *views = @[self.projectLabel, self.moneyLabel, self.withdrawalSpeedLabel, self.earningsLabel, lineView, moneyTitleLabel, timeTitleLabel, earningsTitleLabel];
    
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
    
    self.earningsLabel.sd_layout
    .leftSpaceToView(self.moneyLabel, 0)
    .topSpaceToView(timeTitleLabel, 8)
    .widthIs(WIDTH/3)
    .autoHeightRatio(0);
    
    self.withdrawalSpeedLabel.sd_layout
    .leftSpaceToView(self.earningsLabel, 0)
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
