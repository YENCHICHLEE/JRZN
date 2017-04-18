//
//  UserModel.h
//  JRZN
//
//  Created by 曾国锐 on 16/5/16.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <JSONModel.h>

@interface UserModel : JSONModel

+ (instancetype)shareUserModelManager;
/**
 *  用户名
 */
@property (nonatomic, copy) NSString *userName;
/**
 *  头像
 */
@property (nonatomic, strong) UIImage *headerImage;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *userSex;
/**
 *  id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  电话号码
 */
@property (nonatomic, copy) NSString *userPhoneNumber;
/**
 *  地区
 */
@property (nonatomic, copy) NSString *userRegion;
/**
 *  签名
 */
@property (nonatomic, copy) NSString *userSignature;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *userEmail;

/**
 *  token
 */
@property (nonatomic, copy) NSString *token;

/**
 *  网贷理财筛选条件
 */
@property (nonatomic, strong) NSMutableArray *netLoanFinancingArray;
/**
 *  宝宝理财筛选条件
 */
@property (nonatomic, strong) NSMutableArray *babyFinanceArray;

@end
