//
//  CollectBaseTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "CollectBaseTableViewCell.h"

@implementation CollectBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{

    _headerImageView = [UIImageView new];
    _nameLabel = [UILabel new];
    _scoreLabel = [UILabel new];
    _levelLabel = [UILabel new];
    _platformTypeLabel = [UILabel new];
    
    UILabel *levelTitlelabel = [UILabel new];
    
    
    NSArray *views = @[self.headerImageView, self.nameLabel, self.scoreLabel, self.levelLabel, self.platformTypeLabel, levelTitlelabel];
    
    [self.contentView sd_addSubviews:views];
    
    _headerImageView.image = LIST_IMG;
    _headerImageView.sd_cornerRadius = @5;
    
    _nameLabel.text = @"陆金所";
    _nameLabel.textColor = kBlackTitleColor;
    _nameLabel.font = kMainFont;
    
    _scoreLabel.text = @"金融点评分：4.4分";
    _scoreLabel.textColor = kBlackTitleColor;
    _scoreLabel.font = kMainFont;
    
    _platformTypeLabel.text = @"综合型投资平台";
    _platformTypeLabel.textColor = kGrayTitleColor;
    _platformTypeLabel.font = kDetailFont;
    
    levelTitlelabel.text = @"综合等级";
    levelTitlelabel.textColor = kGrayTitleColor;
    levelTitlelabel.font = kDetailFont;
    levelTitlelabel.textAlignment = NSTextAlignmentRight;
    
    _levelLabel.text = @"A++";
    _levelLabel.textColor = kTabbarHighlightedColor;
    _levelLabel.font = UIFont20;
    _levelLabel.textAlignment = NSTextAlignmentRight;
    
    UIView *contentView = self.contentView;
    
    _headerImageView.sd_layout
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 10)
    .widthIs(120)
    .heightIs(90);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_headerImageView, 20)
    .rightSpaceToView(contentView, 80)
    .topSpaceToView(contentView, 20)
    .autoHeightRatio(0);
    
    _scoreLabel.sd_layout
    .leftSpaceToView(_headerImageView, 20)
    .rightSpaceToView(contentView, 80)
    .autoHeightRatio(0)
    .topSpaceToView(_nameLabel, 10);
    
    _platformTypeLabel.sd_layout
    .leftSpaceToView(_headerImageView, 20)
    .rightSpaceToView(contentView, 80)
    .autoHeightRatio(0)
    .topSpaceToView(_scoreLabel, 10);
    
    
    levelTitlelabel.sd_layout
    .rightSpaceToView(contentView, 20)
    .widthIs(60)
    .autoHeightRatio(0)
    .topSpaceToView(contentView, 35);
    
    _levelLabel.sd_layout
    .rightSpaceToView(contentView, 20)
    .widthIs(60)
    .autoHeightRatio(0)
    .topSpaceToView(levelTitlelabel, 5);
    
    [self setupAutoHeightWithBottomView:self.headerImageView bottomMargin:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
