//
//  InformationBaseTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/5/20.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "InformationModel.h"

@protocol InformationBaseTableViewCellDelegate <NSObject>

/**
 *  轮播图代理
 */
- (void)didSelectedBanner:(NSInteger)index;

@end

@interface InformationBaseTableViewCell : UITableViewCell <SDCycleScrollViewDelegate>

@property (nonatomic, weak) id<InformationBaseTableViewCellDelegate> delegate;

/**
 *  数据模型
 */
@property(nonatomic ,strong) InformationModel *informationModel;
/**
 *  滚动图片区
 */
@property(nonatomic ,strong) SDCycleScrollView *cycleScrollView;


/************************************************/
/*资讯列表-InformationTableViewCell*/

/**
 *  项目名称
 */
@property(nonatomic ,strong) UILabel *projectLabel;
/**
 *  项目图片
 */
@property(nonatomic ,strong) UIImageView *projectImageView;
/**
 *  项目时间
 */
@property(nonatomic ,strong) UILabel *timeLabel;
/**
 *  项目来源
 */
@property(nonatomic ,strong) UILabel *sourceLabel;
/**
 *  人数
 */
@property(nonatomic ,strong) UILabel *numberLabel;

/************************************************/
/************************************************/

+ (NSString *)cellIdentifierForRow:(NSIndexPath *)indexPath;

@end
