//
//  HomeHotTitleCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/14.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeHotTitleCell.h"

@implementation HomeHotTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{
    
    UIView *contentView = self.contentView;
    
    UILabel *hotLabel = [UILabel new];
    hotLabel.text = @"热门产品";
    hotLabel.textColor = kBlackTitleColor;
    hotLabel.font = [UIFont boldSystemFontOfSize:15];
    [contentView addSubview:hotLabel];
    
    hotLabel.sd_layout
    .leftSpaceToView(contentView, 27)
    .topSpaceToView(contentView, 15)
    .autoHeightRatio(0);
    [hotLabel setSingleLineAutoResizeWithMaxWidth:WIDTH];
    
    [self setupAutoHeightWithBottomView:hotLabel bottomMargin:15];
}

@end
