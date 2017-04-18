//
//  OpinionColumnsTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/15.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "OpinionColumnsTableViewCell.h"

@implementation OpinionColumnsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{
    
    self.headerImageView = [UIImageView new];
    self.titleLabel = [UILabel new];
    self.timeLabel = [UILabel new];
    self.nickNameLabel = [UILabel new];
    UIView *lineView = [UIView new];
    
    NSArray *views = @[self.headerImageView, self.titleLabel, self.timeLabel, self.nickNameLabel, lineView];
    
    [self.contentView sd_addSubviews:views];
    
    self.headerImageView.image = HEADER_IMG;
    
    self.nickNameLabel.text = @"默认名称";
    self.nickNameLabel.textColor = kGrayTitleColor;
    self.nickNameLabel.font = kDetailFont;
    self.nickNameLabel.numberOfLines = 0;
    
    self.titleLabel.text = @"看什么看，没见过这么帅的啊！！看什么看，没见过这么帅的啊！！看什么看，没见过这么帅的啊！！看什么看，没见过这么帅的啊！！";
    self.titleLabel.textColor = kBlackTitleColor;
    self.titleLabel.font = kMainFont;
    self.titleLabel.numberOfLines = 0;
    
    self.timeLabel.text = @"2016-6-13";
    self.timeLabel.textColor = kGrayTitleColor;
    self.timeLabel.font = kDetailFont;
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    
    lineView.backgroundColor = kLineColor;
    
    UIView *contentView = self.contentView;
    
    self.headerImageView.sd_layout
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 20)
    .widthIs(40)
    .heightIs(40);
    
    self.nickNameLabel.sd_layout
    .leftSpaceToView(self.headerImageView, 10)
    .rightSpaceToView(contentView, 100)
    .topSpaceToView(contentView, 20)
    .autoHeightRatio(0);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.headerImageView, 10)
    .rightSpaceToView(contentView, 20)
    .topSpaceToView(self.nickNameLabel, 10)
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .rightSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 20)
    .widthIs(100)
    .autoHeightRatio(0);
    
    lineView.sd_layout
    .leftSpaceToView(contentView, 15)
    .rightSpaceToView(contentView, 0)
    .heightIs(1)
    .topSpaceToView(self.titleLabel, 20);
    
    [self setupAutoHeightWithBottomView:lineView bottomMargin:0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
