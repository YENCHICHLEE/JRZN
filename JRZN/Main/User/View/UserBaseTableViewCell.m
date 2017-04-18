//
//  UserBaseTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/3.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "UserBaseTableViewCell.h"

@implementation UserBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (NSString *)cellIdentifierForRow:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {//个人资料
            return @"UserHeaderCell";
        }
            break;
        case 1:
        {//一级菜单
            return @"UserMenuCell";
        }
            break;
            
        default:
            break;
    }
    return @"UserListCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
