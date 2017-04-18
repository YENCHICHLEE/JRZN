//
//  HomeBannerCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeBannerCell.h"

@implementation HomeBannerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

-(void)setUp{
    // 滚动图片区
    self.cycleScrollView = [[SDCycleScrollView alloc] init];
    [self.contentView addSubview:self.cycleScrollView];
    
    
    //设置约束
    CGFloat margin = 0;
    self.cycleScrollView.sd_layout
    .topSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(130);
    
    [self setupAutoHeightWithBottomView:self.cycleScrollView bottomMargin:0];
    
    NSArray *imageArr = @[@"banner@2x.png",@"banner@2x.png",@"banner@2x.png"];
//    NSArray *titleArr = @[@"1",@"2",@"3"];
    
    /*临时放置*/
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;// 分页控件位置
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;// 分页控件风格
    self.cycleScrollView.delegate = self;
//    self.cycleScrollView.titlesGroup = titleArr;
//    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    self.cycleScrollView.localizationImageNamesGroup = imageArr;
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"303"];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(didSelectedBanner:)]) {
        [self.delegate didSelectedBanner:index];
    }
}

@end
