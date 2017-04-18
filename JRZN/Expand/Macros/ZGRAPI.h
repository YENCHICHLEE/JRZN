//
//  ZGRAPI.h
//  AccompanyDrive
//
//  Created by 曾国锐 on 15/7/7.
//  Copyright (c) 2015年 曾国锐. All rights reserved.
//

#ifndef AccompanyDrive_VlooksAPI_h
#define AccompanyDrive_VlooksAPI_h

#define  BaseUrl  @"http://192.168.0.241:8080"  //服务器地址

//jtqb.shizitegong.com:8060 公网地址

#define  BaseCMSUrl  @"https://host"  //CMS服务器地址
//#define  BaseUrl  @""  //上线服务器地址
//#define  BaseUrl  @""  //测试服务器地址


#define kHomeApi [NSString stringWithFormat:@"%@/v1/app/index/base.jhtml",BaseUrl] //首页

#define kLoginApi [NSString stringWithFormat:@"%@/v1/app/login",BaseUrl] //登录
#define kSendCodeApi [NSString stringWithFormat:@"%@/v1/app/sendMessage",BaseUrl] //注册-获取验证码
#define kRegisteredApi [NSString stringWithFormat:@"%@/v1/app/regist",BaseUrl] //注册
#define kRegisterProtocolApi [NSString stringWithFormat:@"%@",BaseUrl] //注册协议


#define kForgotPasswordSendCodeApi [NSString stringWithFormat:@"%@",BaseUrl] //忘记密码-获取验证码
#define kForgotPasswordCheckCodeApi [NSString stringWithFormat:@"%@",BaseUrl] //忘记密码-校验验证码
#define kForgotPasswordApi [NSString stringWithFormat:@"%@",BaseUrl] //忘记密码-设置密码


#define kUpdateUserInfoApi [NSString stringWithFormat:@"%@/v1/app/userInfo/update",BaseUrl] //个人资料修改

#endif
