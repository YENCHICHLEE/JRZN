//
//  FilterBaseTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  筛选条件cell

#import <UIKit/UIKit.h>
#import "FilterModel.h"

@protocol FilterBaseTableViewCellDelegate <NSObject>

/**
 *  分类详情列表代理
 */
- (void)didSelectedFilterButton:(UIButton *)button;


@end

@interface FilterBaseTableViewCell : UITableViewCell

@property (nonatomic, weak) id<FilterBaseTableViewCellDelegate> delegate;

/**
 *  模型
 */
@property (nonatomic, strong) FilterModel *model;

/**
 *  分类列表
 */
@property (nonatomic, strong) UILabel *categoryNameLabel;

/**
 *  底部阴影
 */
@property (nonatomic, strong) UIView *bottomView;

@end
