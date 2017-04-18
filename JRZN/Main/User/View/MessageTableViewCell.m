//
//  MessageTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

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
    
    UIView *lineView = [UIView new];
    
    NSArray *views = @[self.headerImageView, self.titleLabel, self.timeLabel, lineView];
    
    [self.contentView sd_addSubviews:views];
    
    self.headerImageView.image = [UIImage imageNamed:@"P11-9-1photo.png"];
    
    self.titleLabel.text = @"你好，我们已将信息发送至您的邮箱。";
    self.titleLabel.textColor = kBlackTitleColor;
    self.titleLabel.font = kMainFont;
    self.titleLabel.numberOfLines = 0;
    
    self.timeLabel.text = @"2016-6-13";
    self.timeLabel.textColor = kGrayTitleColor;
    self.timeLabel.font = kDetailFont;
    
    lineView.backgroundColor = kLineColor;
    
    UIView *contentView = self.contentView;
    
    self.headerImageView.sd_layout
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 20)
    .widthIs(40)
    .heightIs(40);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.headerImageView, 10)
    .rightSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 20)
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.headerImageView, 10)
    .topSpaceToView(self.titleLabel, 10)
    .widthIs(100)
    .autoHeightRatio(0);
    
    lineView.sd_layout
    .leftSpaceToView(contentView, 15)
    .rightSpaceToView(contentView, 0)
    .heightIs(1)
    .topSpaceToView(self.timeLabel, 20);
    
    [self setupAutoHeightWithBottomView:lineView bottomMargin:0];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
