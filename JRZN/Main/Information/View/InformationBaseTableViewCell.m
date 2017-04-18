//
//  InformationBaseTableViewCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/20.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "InformationBaseTableViewCell.h"

@implementation InformationBaseTableViewCell

+ (NSString *)cellIdentifierForRow:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return @"InformationBannerCell";
    }
    
    return @"InformationTableViewCell";
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
