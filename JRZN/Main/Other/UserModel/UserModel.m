//
//  UserModel.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/16.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (instancetype)shareUserModelManager{

    static UserModel *_shareUserModelManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _shareUserModelManager = [[UserModel alloc] init];
        
    });
    
    return _shareUserModelManager;
}

@end
