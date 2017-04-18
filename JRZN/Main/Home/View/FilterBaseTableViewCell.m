//
//  FilterBaseTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "FilterBaseTableViewCell.h"

@implementation FilterBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return self;
}

- (void)setUp{

    _categoryNameLabel = [UILabel new];
    _categoryNameLabel.textColor = kBlackTitleColor;
    _categoryNameLabel.font = kMainFont;
    [self.contentView addSubview:_categoryNameLabel];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = kViewBackgroundColor;
    [self.contentView addSubview:_bottomView];
    
    UIView *contentView = self.contentView;
    
    _categoryNameLabel.sd_layout
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 10)
    .rightSpaceToView(contentView, 20)
    .heightIs(20);
    
    
    [self setupAutoHeightWithBottomView:self.categoryNameLabel bottomMargin:0];
}

- (void)setModel:(FilterModel *)model{

    _model = model;
    
    if (_model.categoryName.length) {
        _categoryNameLabel.text = _model.categoryName;
    }
    
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (_model.categoryDetailListArray.count) {
        for (int i=0; i<_model.categoryDetailListArray.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i%4*WIDTH/4+10, i/4*(30+10)+40, WIDTH/4-20, 30);
            [button setTitle:_model.categoryDetailListArray[i] forState:UIControlStateNormal];
            [button setTitleColor:kBlackTitleColor forState:UIControlStateNormal];
            [button setBackgroundColor:kLineColor];
            
            if (_model.selectButton == i) {
                [button setTitleColor:kTabbarNormalColor forState:UIControlStateNormal];
                [button setBackgroundColor:kTabbarHighlightedColor];
            }
            
            button.tag = _model.categoryButtonTag + i;
            
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            
            button.titleLabel.font = kDetailFont;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:button];
            
            tempButton = button;
        }
    }
    
    self.bottomView.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(tempButton, 10)
    .heightIs(8);
    
    [self setupAutoHeightWithBottomView:self.bottomView bottomMargin:0];
}

- (void)buttonClick:(UIButton *)button{
    
    [button setTitleColor:kTabbarNormalColor forState:UIControlStateNormal];
    [button setBackgroundColor:kTabbarHighlightedColor];
    
    if ([self.delegate respondsToSelector:@selector(didSelectedFilterButton:)]) {
        [self.delegate didSelectedFilterButton:button];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
