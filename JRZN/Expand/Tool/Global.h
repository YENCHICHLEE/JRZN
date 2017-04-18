//
//  Global.h
//  GeneralModel
//
//  Created by 曾国锐 on 16/3/28.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface Global : NSObject

/**
 *  色值转换图片
 *
 *  @param name 图片
 */
+ (UIImage *)setImageFromColor:(UIColor *)color;

/**
 *  获取字符串的高度
 *
 *  @param string        字符串string
 *  @param font          字符串的字体大小
 *  @param size          字符串显示的size
 *  @param LineBreakMode 字符串显示的方式
 *
 *  @return 字符串的高度
 */
+ (CGFloat)heightForString:(NSString *)string FontSize:(UIFont *)font constrainedSize:(CGSize)size lineBreakMode:(NSLineBreakMode)LineBreakMode;

/**
 *  获取字符串的宽度
 *
 *  @param string        字符串string
 *  @param font          字符串的字体大小
 *  @param size          字符串显示的size
 *  @param LineBreakMode 字符串显示的方式
 *
 *  @return 字符串的宽度
 */
+ (CGFloat)widthForString:(NSString *)string FontSize:(UIFont *)font constrainedSize:(CGSize)size lineBreakMode:(NSLineBreakMode)LineBreakMode;

/**
 *  图片最适合的尺寸大小
 *
 *  @param apImg         图片
 *  @param constrainSize 显示的大小
 *
 *  @return 图片需要剪切的大小
 */
+ (CGSize)AspectSizeFromImage:(UIImage *)apImg ConstrainWith:(CGSize)constrainSize;


/**
 *  压缩图片
 *
 *  @param img  图片
 *  @param size 压缩的大小
 *
 *  @return UIImage
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 *  将nsdate转化为字符串
 *
 *  @param date date日期
 *
 *  @return 字符串
 */
+ (NSString *)getDateString:(NSDate *)date;

/**
 *  将nsdate转化为字符串
 *
 *  @param date date日期
 *
 *  @return 字符串 以天为单位
 */
+ (NSString *)getDateStringByDay:(NSDate *)date;
+ (NSString *)getDateStringByDay2:(NSDate *)date;

/**
 * @brief lengthOfText
 *
 * Detailed 计算text的长度，1个汉字length＋2，1个英文length＋1
 * @param[in] text
 * @param[out]
 * @return int
 * @note
 */
+ (int)lengthOfText:(NSString*)text;


/**
 *  通过文件夹名获取缓存的路径
 *
 *  @param foldName 文件夹名
 *
 *  @return 文件夹缓存的完整路径
 */
+ (NSString *)getCachePathWithFolor:(NSString *)foldName;

/**
 *  跳转到appstore
 */
+ (void)jumpToAppStoreAndMarkApp;


/**
 *  判断手机号码是否合法
 *
 *  @return BOOL
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


/**
 *  判断邮箱是否合法
 *
 *  @return BOOL
 */
+ (BOOL)isValidateEmail:(NSString *)email;


/**
 *  校验密码
 *
 *  @return BOOL
 */
+ (BOOL)isValidatePassword:(NSString *)password;

/**
 *  校验用户名
 *
 *  @return BOOL
 */
+ (BOOL) isValidateUsername:(NSString *)userName;

/**
 *  秒数转换时间格式
 *
 *  @return NSString
 */
+ (NSString *)createTimeFormat:(NSString *)timeStr;

/**
 *  转换时间格式 小时前 分钟前 刚刚
 *
 *  @return NSString
 */
+ (NSString*)getTime:(NSString *)time;

/**
 *  显示手机号的前三位和后四位
 */
+ (NSString*)hiddePhoneNumber:(NSString *)PhoneNum;

/**
 *  获取系统时间戳
 */
+ (NSString *)getTimeStamp;

/**
 *  MD5加密
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  签名验证
 *
 *  array包装一个字典
 *  NSArray *arr = @[@"":@"",@"":@""];
 */
+ (NSString *)getSign:(NSArray *)array;

@end
