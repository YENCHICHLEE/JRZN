//
//  AppointmentTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  我的预约cell

#import <UIKit/UIKit.h>
#import "AppointmentModel.h"
@interface AppointmentTableViewCell : UITableViewCell

/**
 *  模型
 */
@property (nonatomic, strong) AppointmentModel *model;
/**
 *  预约时间
 */
@property (nonatomic, strong) UILabel *appointmentTimeLabel;

/**
 *  创建时间
 */
@property (nonatomic, strong) UILabel *time;

@end
