//
//  HomeBaseTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  

#import "HomeBaseTableViewCell.h"

@implementation HomeBaseTableViewCell

+ (NSString *)cellIdentifierForRow:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {//滚动图片区
                return @"HomeBannerCell";
            }
                break;
            case 1:
            {//一级菜单
                return @"HomeMenuOneCell";
            }
                break;
            case 2:
            {//头条新闻
                return @"HomeHeadlinesCell";
            }
                break;
            case 3:
            {//二级菜单
                return @"HomeMenuTwoCell";
            }
                break;
            case 4:
            {//热门标签
                return @"HomeHotTitleCell";
            }
                break;
                
            default:
                break;
        }
    }else{//热门分类列表
    
        return @"HomeHotCategoryTableViewCell";
    }
    return @"";
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
