//
//  MessageTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  消息cell

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageTableViewCell : UITableViewCell

/**
 *  模型
 */
@property (nonatomic, strong) MessageModel *model;

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
