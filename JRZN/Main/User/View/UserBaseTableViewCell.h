//
//  UserBaseTableViewCell.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/3.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@protocol UserBaseTableViewCellDelegate <NSObject>

/**
 *  个人资料
 */
- (void)didSelectedHeader;

/**
 *  菜单代理-我的收藏-风险评测-预约-帖子
 */
- (void)didSelectedMenu:(UIButton *)button;

@end

@interface UserBaseTableViewCell : UITableViewCell

@property (nonatomic, weak) id<UserBaseTableViewCellDelegate> delegate;
/**
 *  模型
 */
@property (nonatomic, strong) UserModel *model;
/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *headerImageView;

/**
 *  昵称
 */
@property (nonatomic, strong) UILabel *nickNameLabel;

/**
 *  签名
 */
@property (nonatomic, strong) UILabel *signatureLabel;

/**
 *  背景
 */
@property (nonatomic, strong) UIImageView *bgHeaderImageView;


/************************************************/
/*菜单列表-UserListCell*/

/**
 *  列表logo
 */
@property(nonatomic ,strong) UIImageView *listLogoImageView;
/**
 *  列表名称
 */
@property(nonatomic ,strong) UILabel *listNameLabel;

/************************************************/
/************************************************/

/**
 *  获取cell名称
 */
+ (NSString *)cellIdentifierForRow:(NSIndexPath *)indexPath;

@end
