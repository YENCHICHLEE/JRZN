//
//  HomeMenuTwoCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/14.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeMenuTwoCell.h"

@implementation HomeMenuTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{
    
    NSArray *titleArr = @[@"网贷理财", @"基金理财", @"宝宝理财",
                          @"理财工具", @"今融点评",
                          @"关于我们"];
    NSArray *imageArr = @[@"icon_hlwjr.png", @"icon_jjlc.png", @"icon_bblc.png",
                          @"icon_lcgj.png", @"icon_jrdp.png",
                          @"icon_gywm.png"];
    NSArray *selectImageArr = @[@"icon_hlwjr2.png", @"icon_jjlc2.png", @"icon_bblc2.png",
                                @"icon_lcgj2.png", @"icon_jrdp2.png",
                                @"icon_gywm2.png"];
    
    [imageArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *contentView = self.contentView;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [contentView addSubview:button];

        [button setImage:[UIImage imageNamed:imageArr[idx]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImageArr[idx]] forState:UIControlStateHighlighted];
        
        button.frame = CGRectMake(idx%3*WIDTH/3, idx/3*(WIDTH/6+20), WIDTH/3, WIDTH/6);
        
        button.tag = 200+idx;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(idx%3*WIDTH/3, button.y+button.height-10, WIDTH/3, 20)];
        label.text = titleArr[idx];
        label.textColor = kGrayTitleColor;
        label.font = kMainFont;
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:label];
        
    }];
    
    
    //阴影线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, WIDTH/6+20, WIDTH, 1)];
    lineView1.backgroundColor = kViewBackgroundColor;
    [self.contentView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/3-0.5, 0, 1, lineView1.y*2)];
    lineView2.backgroundColor = kViewBackgroundColor;
    [self.contentView addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/3*2-0.5, 0, 1, lineView1.y*2)];
    lineView3.backgroundColor = kViewBackgroundColor;
    [self.contentView addSubview:lineView3];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, lineView1.y*2, WIDTH, 8)];
    lineView4.backgroundColor = kViewBackgroundColor;
    [self.contentView addSubview:lineView4];
    
    [self setupAutoHeightWithBottomView:lineView4 bottomMargin:0];
    
}

- (void)buttonClick:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(didSelectedMenuTwo:)]) {
        [self.delegate didSelectedMenuTwo:button];
    }
}

@end
