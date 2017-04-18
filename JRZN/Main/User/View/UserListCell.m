//
//  UserListCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/3.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "UserListCell.h"

@implementation UserListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{

    self.listLogoImageView = [UIImageView new];
    self.imageView.image = [UIImage imageNamed:@"icon_shezhi.png"];
    
    self.listNameLabel = [UILabel new];
    self.listNameLabel.text = @"设置";
    self.listNameLabel.textColor = kBlackTitleColor;
    self.listNameLabel.font = kMainFont;
    
    
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.image = [UIImage imageNamed:@"icon_qianjin.png"];
    
    NSArray *views = @[self.listLogoImageView, self.listNameLabel, rightImageView];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    CGFloat margin = 15;
    
    
    self.listLogoImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .centerYIs(30)
    .heightIs(20)
    .widthIs(20);
    
    self.listNameLabel.sd_layout
    .leftSpaceToView(self.listLogoImageView, margin-5)
    .rightSpaceToView(contentView, 60)
    .centerYEqualToView(self.listLogoImageView)
    .heightIs(20);
    
    rightImageView.sd_layout
    .rightSpaceToView(contentView, 10)
    .centerYIs(30)
    .heightIs(15)
    .widthIs(15);
    
    [self setupAutoHeightWithBottomView:self.listLogoImageView bottomMargin:20];
}

@end
