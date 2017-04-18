//
//  OpinionColumnsTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/15.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  观点专栏cell

#import <UIKit/UIKit.h>
#import "OpinionColumnsModel.h"

@interface OpinionColumnsTableViewCell : UITableViewCell

/**
 *  模型
 */
@property (nonatomic, strong) OpinionColumnsModel *model;

/**
 *  用户名
 */
@property (nonatomic, strong) UILabel *nickNameLabel;
/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *headerImageView;

/**
 *  内容
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  时间
 */
@property (nonatomic, strong) UILabel *timeLabel;

@end
