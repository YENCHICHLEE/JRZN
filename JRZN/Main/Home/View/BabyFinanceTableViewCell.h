//
//  BabyFinanceTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/14.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BabyFinanceTableViewCell : UITableViewCell

/**
 *  项目名称
 */
@property(nonatomic ,strong) UILabel *projectLabel;
/**
 *  项目收益金额
 */
@property(nonatomic ,strong) UILabel *moneyLabel;
/**
 *  提现速度
 */
@property(nonatomic ,strong) UILabel *withdrawalSpeedLabel;
/**
 *  项目年化收益
 */
@property(nonatomic ,strong) UILabel *earningsLabel;

@end
