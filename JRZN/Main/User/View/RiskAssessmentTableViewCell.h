//
//  RiskAssessmentTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  我的风险评估cell

#import <UIKit/UIKit.h>
#import "RiskAssessmentModel.h"

@interface RiskAssessmentTableViewCell : UITableViewCell

/**
 *  模型
 */
@property (nonatomic, strong) RiskAssessmentModel *model;
/**
 *  风险评估类型
 */
@property (nonatomic, strong) UILabel *riskAssessmentTypeLabel;

/**
 *  时间
 */
@property (nonatomic, strong) UILabel *time;

@end
