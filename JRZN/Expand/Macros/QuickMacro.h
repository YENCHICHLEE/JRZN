//
//  QuickMacro.h
//  SupervisionSystem
//
//  Created by 曾国锐 on 15/10/28.
//  Copyright © 2015年 曾国锐. All rights reserved.
//

#ifndef QuickMacro_h
#define QuickMacro_h

#define VERSIO_NUMBER @"1"
#define APIKEY  @""
#define kImageDaqoKey @""

#define kSignKey @"U5rRI65jvGBFNG23aZHZGxOUQnmIEPyV"

//屏幕宽高
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

//比例适配
#define WIDTH_S self.view.frame.size.width/320
#define HEIGHT_S self.view.frame.size.height/568

//屏幕frame,bounds,size
#define zScreenFrame [UIScreen mainScreen].bounds
#define zScreenBounds [UIScreen mainScreen].bounds
#define zScreenSize [UIScreen mainScreen].bounds.size

//ios系统版本
#define ios9x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)
#define ios8x (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0f))
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)
#define iosNot6x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)

//手机型号
#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f)

//颜色

#define rgb(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define hexColor(colorV) [UIColor colorWithHexColorString:@#colorV]
#define hexColorAlpha(colorV,a) [UIColor colorWithHexColorString:@#colorV alpha:a];


//colors
#define UIColorFromRGB(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

// 3.自定义Log
#ifdef DEBUG
#define DDLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DDLog(...)
#endif

//字体
#define UIFont10 [UIFont systemFontOfSize:10]
#define UIFont11 [UIFont systemFontOfSize:11]
#define UIFont12 [UIFont systemFontOfSize:12]
#define UIFont13 [UIFont systemFontOfSize:13]
#define UIFont14 [UIFont systemFontOfSize:14]
#define UIFont15 [UIFont systemFontOfSize:15]
#define UIFont16 [UIFont systemFontOfSize:16]
#define UIFont17 [UIFont systemFontOfSize:17]
#define UIFont18 [UIFont systemFontOfSize:18]
#define UIFont19 [UIFont systemFontOfSize:19]
#define UIFont20 [UIFont systemFontOfSize:20]

//cell字号
#define kMainFont UIFont15//一级主标题字号
#define kDetailFont UIFont13//二级字号
#define kGrayFont UIFont11//三级字号


//颜色
//#define kNavColor UIColorFromRGB(0x357dc1, 1)//导航背景颜色

#define  kViewBackgroundColor UIColorFromRGB(0xeeeeee, 1)//界面灰色背景颜色

#define kTabbarHighlightedColor UIColorFromRGB(0xff9600, 1)//橙色
#define kTabbarNormalColor [UIColor whiteColor]//选项卡平常
#define kLineColor UIColorFromRGB(0xe5e5e5, 1)//灰色-分割线
#define kButtonBgGrayColor UIColorFromRGB(0xb2b2b2, 1)//灰色-按钮灰色背景

#define kBlackTitleColor UIColorFromRGB(0x2b2e43, 1)//一级蓝黑色
#define kGrayTitleColor UIColorFromRGB(0x898989, 1)//二级灰色
#define kRedTitleColor UIColorFromRGB(0xf05853, 1)//红色



//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:［NSBundle mainBundle]pathForResource:file ofType:ext］

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:nil］

//导航
//#define NAV_IMAGE [UIImage imageNamed:@"nav.png"]
//默认头像
#define HEADER_IMG [UIImage imageNamed:@"photo_wdl.png"]
//默认列表图
#define LIST_IMG [UIImage imageNamed:@"banner.png"]

//字符限制
#define kMaxPhoneNums 11        //手机号
#define kMaxpasswordNums 16     //密码
#define kMaxNickNameNums 10     //昵称
#define kMaxVerficationNums 6   //验证码
#define kMaxSigningNums 99     //个性签名

#endif /* QuickMacro_h */
