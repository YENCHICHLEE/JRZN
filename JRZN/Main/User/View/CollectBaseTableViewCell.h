//
//  CollectBaseTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  我的收藏cell

#import <UIKit/UIKit.h>

@interface CollectBaseTableViewCell : UITableViewCell

/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *headerImageView;

/**
 *  列表名称
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 *  评分
 */
@property (nonatomic, strong) UILabel *scoreLabel;

/**
 *  综合等级
 */
@property (nonatomic, strong) UILabel *levelLabel;

/**
 *  平台类型
 */
@property (nonatomic, strong) UILabel *platformTypeLabel;

@end
