//
//  HomeHeadlinesCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/14.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeHeadlinesScrollView.h"
#import "HomeHeadlinesCell.h"

@implementation HomeHeadlinesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{

    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"今融头条";
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = kBlackTitleColor;
    
    
    UILabel *headlinesLabel = [UILabel new];
    headlinesLabel.text = @"【热门文章】飞货的启示:找准商业的痛点";
//    headlinesLabel.numberOfLines = 0;
    headlinesLabel.font = kDetailFont;
    headlinesLabel.textColor = kBlackTitleColor;
    
    ///
    UILabel *header2Label = [UILabel new];
    header2Label.text = @"行业";
    header2Label.font = UIFont12;
    header2Label.textAlignment = NSTextAlignmentCenter;
    header2Label.textColor = kRedTitleColor;
    header2Label.layer.borderWidth = 1.0f;
    header2Label.layer.cornerRadius = 2;
    header2Label.layer.borderColor = kRedTitleColor.CGColor;
    
    UILabel *headlines2Label = [UILabel new];
    headlines2Label.text = @"【热门文章】飞货的启示:找准商业的痛点";
//    headlines2Label.numberOfLines = 0;
    headlines2Label.font = kDetailFont;
    headlines2Label.textColor = kBlackTitleColor;
    
    //阴影
    UIView *shadowTopView = [UIView new];
    UIView *shadowbottomView = [UIView new];
    shadowTopView.backgroundColor = kViewBackgroundColor;
    shadowbottomView.backgroundColor = kViewBackgroundColor;
    
    NSArray *views = @[titleLabel, headlinesLabel, header2Label, headlines2Label, shadowTopView, shadowbottomView];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    shadowTopView.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .heightIs(8);
    
    titleLabel.sd_layout
    .topSpaceToView(shadowTopView, 18)
    .leftSpaceToView(contentView, 20)
    .widthIs(45)
    .heightIs(45);
    
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i=0; i<5; i++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-65, 78)];
        
        UILabel *headerLabel = [UILabel new];
        headerLabel.text = @"热评";
        headerLabel.font = UIFont12;
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.textColor = kRedTitleColor;
        headerLabel.layer.borderWidth = 0.5f;
        headerLabel.layer.cornerRadius = 2;
        headerLabel.layer.borderColor = kRedTitleColor.CGColor;
        
        [bgView addSubview:headerLabel];
        
        
        UIButton *headlinesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [headlinesButton setTitle:@"【热门文章】飞货的启示:找准商业的痛点" forState:UIControlStateNormal];
        [headlinesButton setTitleColor:kBlackTitleColor forState:UIControlStateNormal];
        headlinesButton.titleLabel.font = kDetailFont;
        headlinesButton.tag = 100+i;
        headlinesButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        headlinesButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        @weakify(self)
        [[headlinesButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            UIButton *button = (UIButton *)x;
            if ([self.delegate respondsToSelector:@selector(didSelectedHomeHeadlines:)]) {
                [self.delegate didSelectedHomeHeadlines:button.tag];
            }
        }];
        
        [bgView addSubview:headlinesButton];
        
        headerLabel.sd_layout
        .leftSpaceToView(bgView, 0)
        .topSpaceToView(bgView,20)
        .widthIs(30)
        .heightIs(15);
        
        headlinesButton.sd_layout
        .leftSpaceToView(headerLabel, 3)
        .topSpaceToView(bgView, 15)
        .widthIs(WIDTH-108)
        .heightIs(25);
        
        
        UILabel *headerLabel2 = [UILabel new];
        headerLabel2.text = @"行业";
        headerLabel2.font = UIFont12;
        headerLabel2.textAlignment = NSTextAlignmentCenter;
        headerLabel2.textColor = kRedTitleColor;
        headerLabel2.layer.borderWidth = 0.5f;
        headerLabel2.layer.cornerRadius = 2;
        headerLabel2.layer.borderColor = kRedTitleColor.CGColor;
        
        [bgView addSubview:headerLabel2];
        
        
        UIButton *headlinesButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [headlinesButton2 setTitle:@"【专题研究】一线房价为什么这么疯" forState:UIControlStateNormal];
        [headlinesButton2 setTitleColor:kBlackTitleColor forState:UIControlStateNormal];
        headlinesButton2.titleLabel.font = kDetailFont;
        headlinesButton2.tag = 200+i;
        headlinesButton2.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        headlinesButton2.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [[headlinesButton2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            UIButton *button = (UIButton *)x;
            if ([self.delegate respondsToSelector:@selector(didSelectedHomeHeadlines:)]) {
                [self.delegate didSelectedHomeHeadlines:button.tag];
            }
        }];
        [bgView addSubview:headlinesButton2];
        
        headerLabel2.sd_layout
        .leftSpaceToView(bgView, 0)
        .topSpaceToView(headerLabel,10)
        .widthIs(30)
        .heightIs(15);
        
        headlinesButton2.sd_layout
        .leftSpaceToView(headerLabel, 3)
        .topSpaceToView(headlinesButton, 0)
        .widthIs(WIDTH-108)
        .heightIs(25);
        
        [tempArr addObject:bgView];
    }
    
    HomeHeadlinesScrollView *header = [[HomeHeadlinesScrollView alloc] initWithFrame:CGRectMake(titleLabel.x+titleLabel.width+10, 10, WIDTH, 78)];
    header.imageViewAry = tempArr;
    
    [header shouldAutoShow:YES];
    
    [self.contentView addSubview:header];
    
    header.sd_layout
    .leftSpaceToView(titleLabel, 10)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(shadowTopView, 0)
    .heightIs(78);
    
    shadowbottomView.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(titleLabel, 16)
    .heightIs(8);
    
    [self setupAutoHeightWithBottomView:shadowbottomView bottomMargin:0];
}

@end
