//
//  HomeMenuOneCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeMenuOneCell.h"

@implementation HomeMenuOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{

    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setImage:[UIImage imageNamed:@"icon_fxcp.png"] forState:UIControlStateNormal];
    testButton.tag = 100;
    [testButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *supermarketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [supermarketButton setImage:[UIImage imageNamed:@"icon_jrcs.png"] forState:UIControlStateNormal];
    supermarketButton.tag = 101;
    [supermarketButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *consultantButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [consultantButton setImage:[UIImage imageNamed:@"icon_tzgw.png"] forState:UIControlStateNormal];
    consultantButton.tag = 102;
    [consultantButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *researchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [researchButton setImage:[UIImage imageNamed:@"icon_yjzx.png"] forState:UIControlStateNormal];
    researchButton.tag = 103;
    [researchButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *testLabel = [UILabel new];
    testLabel.text = @"风险评测";
    testLabel.textColor = kBlackTitleColor;
    testLabel.font = kMainFont;
    testLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *supermarketLabel = [UILabel new];
    supermarketLabel.text = @"金融超市";
    supermarketLabel.textColor = kBlackTitleColor;
    supermarketLabel.font = kMainFont;
    supermarketLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *consultantLabel = [UILabel new];
    consultantLabel.text = @"投资顾问";
    consultantLabel.textColor = kBlackTitleColor;
    consultantLabel.font = kMainFont;
    consultantLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *researchLabel = [UILabel new];
    researchLabel.text = @"研究中心";
    researchLabel.textColor = kBlackTitleColor;
    researchLabel.font = kMainFont;
    researchLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *views = @[testButton, supermarketButton, consultantButton, researchButton, testLabel, supermarketLabel, consultantLabel, researchLabel];
    
    [self.contentView sd_addSubviews:views];
    

    UIView *contentView = self.contentView;
    
    testButton.sd_layout
    .topSpaceToView(contentView, 10)
    .leftSpaceToView(contentView, 0)
    .widthIs(WIDTH/4)
    .autoHeightRatio(0.7);
    
    supermarketButton.sd_layout
    .topEqualToView(testButton)
    .leftSpaceToView(testButton, 0)
    .widthIs(WIDTH/4)
    .autoHeightRatio(0.7);
    
    consultantButton.sd_layout
    .topEqualToView(testButton)
    .leftSpaceToView(supermarketButton, 0)
    .widthIs(WIDTH/4)
    .autoHeightRatio(0.7);
    
    researchButton.sd_layout
    .topEqualToView(testButton)
    .leftSpaceToView(consultantButton, 0)
    .rightSpaceToView(contentView, 0)
    .widthIs(WIDTH/4)
    .autoHeightRatio(0.7);
    
    //
    testLabel.sd_layout
    .topSpaceToView(testButton, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(WIDTH/4)
    .heightIs(20);
    
    supermarketLabel.sd_layout
    .topEqualToView(testLabel)
    .leftSpaceToView(testLabel, 0)
    .widthIs(WIDTH/4)
    .heightIs(20);
    
    consultantLabel.sd_layout
    .topEqualToView(testLabel)
    .leftSpaceToView(supermarketLabel, 0)
    .widthIs(WIDTH/4)
    .heightIs(20);
    
    researchLabel.sd_layout
    .topEqualToView(testLabel)
    .leftSpaceToView(consultantLabel, 0)
    .rightSpaceToView(contentView, 0)
    .widthIs(WIDTH/4)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomView:testLabel bottomMargin:10];
}

- (void)buttonClick:(UIButton *)button{

    if ([self.delegate respondsToSelector:@selector(didSelectedMenuOne:)]) {
        [self.delegate didSelectedMenuOne:button];
    }
}

@end
