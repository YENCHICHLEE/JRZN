//
//  InformationTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/20.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "InformationTableViewCell.h"

@implementation InformationTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{
    
    self.projectLabel = [UILabel new];
    self.projectImageView = [UIImageView new];
    self.timeLabel = [UILabel new];
    self.sourceLabel = [UILabel new];
    self.numberLabel = [UILabel new];

    UIImageView *numberImageView = [UIImageView new];
    numberImageView.image = [UIImage imageNamed:@"home2.png"];
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kViewBackgroundColor;
    
    NSArray *views = @[self.projectLabel, self.projectImageView, self.timeLabel, self.sourceLabel, self.numberLabel, lineView, numberImageView];
    
    [self.contentView sd_addSubviews:views];
    
    
    self.projectImageView.image = [UIImage imageNamed:@"banner"];
    
    self.projectLabel.textColor = kBlackTitleColor;
    self.projectLabel.font = kMainFont;
    self.projectLabel.numberOfLines = 0;
    self.projectLabel.text = @"互联网金融领域当下最值得关注的机会与风险";
    
    self.sourceLabel.text = @"今融指南";
    self.sourceLabel.textColor = kGrayTitleColor;
    self.sourceLabel.font = kDetailFont;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%d",arc4random()%3000+500];
    self.numberLabel.textColor = kGrayTitleColor;
    self.numberLabel.font = kDetailFont;
    
    self.timeLabel.text = @"1分钟前";
    self.timeLabel.textColor = kGrayTitleColor;
    self.timeLabel.font = kDetailFont;
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    lineView.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(contentView, 0)
    .heightIs(8);
    
    self.projectImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(lineView, 8)
    .widthIs(115)
    .heightIs(80);
    
    self.projectLabel.sd_layout
    .leftSpaceToView(self.projectImageView, margin)
    .topSpaceToView(lineView, 8)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .rightSpaceToView(contentView, margin)
    .topSpaceToView(self.projectLabel, 30)
    .widthIs(50)
    .heightIs(15);
    
    self.numberLabel.sd_layout
    .rightSpaceToView(self.timeLabel, 5)
    .topEqualToView(self.timeLabel)
    .widthIs(40)
    .heightIs(15);
    
    numberImageView.sd_layout
    .rightSpaceToView(self.numberLabel, 2)
    .topEqualToView(self.timeLabel)
    .widthIs(15)
    .heightIs(15);
    
    self.sourceLabel.sd_layout
    .rightSpaceToView(numberImageView, 5)
    .topEqualToView(self.timeLabel)
    .widthIs(60)
    .heightIs(15);
    
//    lineView.sd_layout
//    .leftSpaceToView(contentView, 0)
//    .topSpaceToView(self.sourceLabel, 10)
//    .rightSpaceToView(contentView, 0)
//    .heightIs(8);
    
    
//    [self setupAutoHeightWithBottomView:lineView bottomMargin:0];
    [self setupAutoHeightWithBottomViewsArray:@[self.projectImageView, self.sourceLabel] bottomMargin:8];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
