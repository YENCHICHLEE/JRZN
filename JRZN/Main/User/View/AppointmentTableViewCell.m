//
//  AppointmentTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "AppointmentTableViewCell.h"

@implementation AppointmentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{
    
    self.appointmentTimeLabel = [UILabel new];
    self.time = [UILabel new];
    
    
    UILabel *titlelabel = [UILabel new];
    UIView *lineView = [UIView new];
    
    NSArray *views = @[self.appointmentTimeLabel, self.time, titlelabel, lineView];
    
    [self.contentView sd_addSubviews:views];
    
    self.appointmentTimeLabel.text = @"我的预约时间：2016-02-05 21:00到22:00";
    self.appointmentTimeLabel.textColor = kBlackTitleColor;
    self.appointmentTimeLabel.font = kMainFont;
    
    self.time.text = @"2016-6-13";
    self.time.textColor = kGrayTitleColor;
    self.time.font = kDetailFont;
    
    titlelabel.text = @"查看详情";
    titlelabel.textColor = kGrayTitleColor;
    titlelabel.font = kDetailFont;
    titlelabel.textAlignment = NSTextAlignmentRight;
    
    lineView.backgroundColor = kLineColor;
    
    UIView *contentView = self.contentView;
    
    self.appointmentTimeLabel.sd_layout
    .leftSpaceToView(contentView, 20)
    .rightSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 20)
    .autoHeightRatio(0);
    
    self.time.sd_layout
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(self.appointmentTimeLabel, 15)
    .widthIs(100)
    .autoHeightRatio(0);
    
    titlelabel.sd_layout
    .rightSpaceToView(contentView, 20)
    .topSpaceToView(self.appointmentTimeLabel, 15)
    .widthIs(60)
    .autoHeightRatio(0);
    
    lineView.sd_layout
    .leftSpaceToView(contentView, 15)
    .rightSpaceToView(contentView, 0)
    .heightIs(1)
    .topSpaceToView(self.time, 20);
    
    [self setupAutoHeightWithBottomView:lineView bottomMargin:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
