//
//  NSString+Extension.h
//  HYJFIOS
//
//  Created by 曾国锐 on 15/12/28.
//  Copyright © 2015年 sztg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 * str 传入参数
 * return 加密后的参数
 */
- (NSString *)md5:(NSString *)str;

/**
 * 校验手机号码
 */
- (BOOL)validatePhone:(NSString *)phone;

- (BOOL)validateUserPhone:(NSString *)str;

/**
 * 检验邮箱
 */
-(BOOL)isValidateEmail:(NSString *)email;


/**
 *  校验银行卡
 */
- (BOOL)checkCardNo:(NSString*)cardNo;


/**
 * 时间戳转换
 */
- (NSString *)timeWithDate:(NSString *)timeDate;

/**
 *  时间戳转换
 *
 *  @param time
 *
 *  @return 时间显示
 */
- (NSString*)stringWithTime:(NSString *)time;

/**
 *  显示银行卡的前四位和后四位
 */
- (NSString*)hiddeBankNumber:(NSString *)bankNum;

/**
 *  显示手机号的前三位和后四位
 */
- (NSString*)hiddePhoneNumber:(NSString *)PhoneNum;

/**
 *  显示身份证的前三位和后四位
 */
- (NSString*)hiddeIdCardNumber:(NSString *)IdCardNum;

/**
 *  显示银行卡后四位
 */
- (NSString*)hiddeBankCardNumber:(NSString *)bankNum;

//base64图片转换
- (NSString*)encodeURL:(NSString *)string;

/**
 *	@brief	正则校验-身份证号码
 *
 *	@param 	value 	输入身份证号码
 *
 *	@return	返回是否合法身份证号（BOOL）
 */
- (BOOL)validateIdCard:(NSString *)value;

/**
 *  计算缓存大小
 */
- (NSString *)fileSizeWithInterge:(NSInteger)size;

@end
