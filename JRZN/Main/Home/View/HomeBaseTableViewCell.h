//
//  HomeBaseTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/5/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "SDCycleScrollView.h"

@protocol HomeBaseTableViewCellDelegate <NSObject>

/**
 *  轮播图代理
 */
- (void)didSelectedBanner:(NSInteger)index;
/**
 *  一级菜单代理-风险测评
 */
- (void)didSelectedMenuOne:(UIButton *)button;
/**
 *  二级菜单代理-互联网金融
 */
- (void)didSelectedMenuTwo:(UIButton *)button;
/**
 *  头条新闻代理
 */
- (void)didSelectedHomeHeadlines:(NSInteger)index;

@end

@interface HomeBaseTableViewCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (nonatomic, weak) id<HomeBaseTableViewCellDelegate> delegate;

/**
 *  数据模型
 */
@property(nonatomic ,strong) HomeModel *homeModel;
/**
 *  滚动图片区
 */
@property(nonatomic ,strong) SDCycleScrollView *cycleScrollView;

/************************************************/
/*热门分类列表-HomeHotCategoryTableViewCell*/

/**
 *  项目名称
 */
@property(nonatomic ,strong) UILabel *projectLabel;
/**
 *  项目金额
 */
@property(nonatomic ,strong) UILabel *moneyLabel;
/**
 *  项目期限
 */
@property(nonatomic ,strong) UILabel *timeLabel;
/**
 *  项目年化收益
 */
@property(nonatomic ,strong) UILabel *earningsLabel;

/************************************************/
/************************************************/

/**
 *  获取cell名称
 */
+ (NSString *)cellIdentifierForRow:(NSIndexPath *)indexPath;

@end
