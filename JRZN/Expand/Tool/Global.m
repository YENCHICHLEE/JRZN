//
//  Global.m
//  GeneralModel
//
//  Created by 曾国锐 on 16/3/28.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "Global.h"

@implementation Global

/**
 *  色值转换图片
 *
 *  @param name 图片
 */
+ (UIImage *)setImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, WIDTH, HEIGHT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

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
+ (CGFloat)heightForString:(NSString *)string FontSize:(UIFont *)font constrainedSize:(CGSize)size lineBreakMode:(NSLineBreakMode)LineBreakMode
{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    
    //modify by sy to fix iOS6
    if (__IPHONE_OS_VERSION_MIN_REQUIRED > 70000) {
        CGRect sizeToFit = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        return sizeToFit.size.height;
    }else{
        
        CGSize stringSize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        return  stringSize.height;
    }
    
    
}

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
+ (CGFloat)widthForString:(NSString *)string FontSize:(UIFont *)font constrainedSize:(CGSize)size lineBreakMode:(NSLineBreakMode)LineBreakMode
{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];;
    
    //modify by sy to fix iOS6
    if (__IPHONE_OS_VERSION_MIN_REQUIRED > 70000) {
        CGRect sizeToFit = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        return sizeToFit.size.width;
    }else{
        
        CGSize stringSize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        return  stringSize.width;
    }
}

/**
 *  图片最适合的尺寸大小
 *
 *  @param apImg         图片
 *  @param constrainSize 显示的大小
 *
 *  @return 图片需要剪切的大小
 */
+ (CGSize)AspectSizeFromImage:(UIImage *)apImg ConstrainWith:(CGSize)constrainSize
{
    CGSize newSize = CGSizeMake(0, 0);
    CGFloat wScaleRate = apImg.size.width/constrainSize.width;
    CGFloat hScaleRate = apImg.size.height/constrainSize.height;
    CGFloat imgScaleRate = MAX(wScaleRate, hScaleRate);
    if (imgScaleRate<1.0) {
        return constrainSize;
    }
    if (imgScaleRate>0) {
        newSize.width = apImg.size.width/imgScaleRate;
        newSize.height = apImg.size.height/imgScaleRate;
    }
    return newSize;
}


/**
 *  压缩图片
 *
 *  @param img  图片
 *  @param size 压缩的大小
 *
 *  @return UIImage
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  将nsdate转化为字符串
 *
 *  @param date date日期
 *
 *  @return 字符串
 */
+ (NSString *)getDateString:(NSDate *)date
{
    NSString *format = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone *localZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:localZone];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)getDateStringByDay:(NSDate *)date
{
    NSString *format = @"yyyy-MM-dd";
    NSTimeZone *localZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:localZone];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}
+ (NSString *)getDateStringByDay2:(NSDate *)date
{
    NSString *format = @"yyyy.MM.dd HH:mm";
    NSTimeZone *localZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:localZone];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/**
 * @brief lengthOfText
 *
 * Detailed 计算text的长度，1个汉字length＋2，1个英文length＋1
 * @param[in] text
 * @param[out]
 * @return int
 * @note
 */
+ (int)lengthOfText:(NSString*)text
{
    long len = [text length];
    int lenthText = 0;
    for (int i = 0; i < len; i++) {
        unichar t = [text characterAtIndex:i];
        // 汉字，标点符号
        if ((t >= 0x4e00 && t <= 0x9fff) || (t >= 0x3000 && t <= 0x303f) || (t >= 0xff00 && t <= 0xffef)) {
            lenthText += 2;
        }
        else {
            lenthText++;
        }
    }
    return lenthText;
}


/**
 *  通过文件夹名获取缓存的路径
 *
 *  @param foldName 文件夹名
 *
 *  @return 文件夹缓存的完整路径
 */
+ (NSString *)getCachePathWithFolor:(NSString *)foldName
{
    BOOL isDir = YES;
    NSError *error = nil;
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches"];
    if (foldName) {
        path = [path stringByAppendingPathComponent:foldName];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        if (error) {
            NSLog(@"Catch Error while create path %@",error);
            return nil;
        }
    }
    return path;
}


+ (void) jumpToAppStoreAndMarkApp
{
    if (iOS7) {
        NSString *str = @"itms-apps://itunes.apple.com/app/idxxxxx";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    }else{
        NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=xxxxx";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    }
}

/**
 *  判断手机号码是否合法
 *
 *  @return BOOL
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSString * ALL = @"^[1][34578][0-9]{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestall = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ALL];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || [regextestall evaluateWithObject:mobileNum] ==YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


/**
 *  判断邮箱是否合法
 *
 *  @return BOOL
 */
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/**
 *  校验密码
 *
 *  @return BOOL
 */
+ (BOOL)isValidatePassword:(NSString *)password
{
    NSString *regex = @"^[\\w\\d_]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:password];
}


/**
 *  校验用户名
 *
 *  @return BOOL
 */
+ (BOOL) isValidateUsername:(NSString *)userName
{
    NSString *regex = @"^[\\w\\d_]{4,10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:userName];
}

/**
 *  秒数转换时间格式
 *
 *  @return NSString
 */
+ (NSString *)createTimeFormat:(NSString *)timeStr{
    NSString *str;
    
    float tempValue1;//秒
    float tempValue2;//分
    float tempValue3;//小时
    
    tempValue1 = [timeStr intValue]%60;
    tempValue2 = [timeStr intValue]%3600/60;
    tempValue3 = [timeStr intValue]/3600;
    
    if (tempValue1 <10) {
        str = [NSString stringWithFormat:@"0%d",(int)tempValue1];
    }
    else
    {
        str = [NSString stringWithFormat:@"%d",(int)tempValue1];
    }
    if (tempValue2 <10) {
        str = [NSString stringWithFormat:@"0%d:%@",(int)tempValue2,str];
    }
    else
    {
        str = [NSString stringWithFormat:@"%d:%@",(int)tempValue2,str];
    }
    if (tempValue3 <10) {
        str = [NSString stringWithFormat:@"0%d:%@",(int)tempValue3,str];
    }
    else
    {
        str = [NSString stringWithFormat:@"%d:%@",(int)tempValue3,str];
    }
    return str;
}

/**
 *  转换时间格式 小时前 分钟前 刚刚
 *
 *  @return NSString
 */
+ (NSString*)getTime:(NSString *)time
{
    if ( time == nil )
    {
        return nil;
    }
    NSLog(@"%@",time);
    //NSString *subString = [time substringWithRange:NSMakeRange(0, 10)];
    
    //获得返回的时间戳
    long long  returnTime = [time longLongValue]/1000;
    
    NSLog(@"%lld",returnTime);
    
    //创建时间格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //获得当前的时间
    NSDate *date = [NSDate date];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //d得到当前的日期的凌晨12点
    NSString *noTime = [NSString stringWithFormat:@"%@ 00:00:00",[formatter stringFromDate:date]];
    
    NSLog(@"%@",noTime);
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //把获得的当前日期的凌晨12点转化为nsdate
    NSDate *nowDay = [formatter dateFromString:noTime];
    
    NSLog(@"%@",nowDay);
    //获得当前的时间戳
    long nowTime =  [nowDay timeIntervalSince1970];
    
    NSLog(@"%ld",nowTime);
    
    //获得相差多少秒
    long long b = nowTime-returnTime;
    
    NSLog(@"%lld",b);
    //把相差的时间戳转化为多少天相差
    long long   c = b/(60*60*24);
    
    NSLog(@"%lld",c);
    
    //把返回的时间戳转化为时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:returnTime];
    
    if ( c < 1 )
    {
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
        NSString *nowYear = [formatter stringFromDate:date];
        
        NSString *lastYear  = [formatter stringFromDate:confromTimesp];
        
        if ([nowYear isEqualToString:lastYear]) {
            
            //            [formatter setDateFormat:@" HH:mm"];
            //
            //            return [formatter stringFromDate:confromTimesp];
            
            long long currentTime = [[NSDate date] timeIntervalSince1970];
            
            long long deltaTime = currentTime - returnTime;
            
            if ( deltaTime >= 60*60 )//[1小时，当天24点）: HH小时前，1小时前~23小时前；
                
            {
                
                long long hour = deltaTime/(60*60);
                
                return [NSString stringWithFormat:@"%lld小时前", hour];
                
            }
            
            else if( deltaTime < 60*60 && deltaTime >= 60)//[1分钟，1小时)：MM分钟前，1分钟前~59分钟前；
                
            {
                
                long long min = deltaTime/60;
                
                return [NSString stringWithFormat:@"%lld分钟前", min];
                
            }
            
            else if( deltaTime < 60 && deltaTime >= 0 )//[0，1分钟）：刚刚；
                
            {
                
                return @"刚刚";
                
            }
            
            return @"";
        }else
        {
            // [formatter setDateFormat:@""];
            
            // NSString *later = [formatter stringFromDate:confromTimesp];
            
            NSString *t = @"昨天";
            
            return t;
        }
        
    }else if(c<6&&1<=c)
    {
        // [formatter setDateFormat:@""];
        
        NSString *s ;
        
        s = [NSString stringWithFormat:@"%lld天前",c+1];
        
        NSLog(@"%lld天前%@",c,s);
        
        return s;
    }else
    {
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
        NSString *s = [formatter stringFromDate:confromTimesp];
        
        if (s!=nil) {
            
            NSArray *stingArr = [s componentsSeparatedByString:@"-"];
            
            s = [NSString stringWithFormat:@"%d-%d-%d",[stingArr[0] intValue],[stingArr[1] intValue],[stingArr[2] intValue]];
            
        }
        
        return s;
    }
}

/**
 *  显示手机号的前三位和后四位
 */
+ (NSString*)hiddePhoneNumber:(NSString *)PhoneNum{
    
    NSString *leftStr=[PhoneNum substringToIndex:3];//左侧4个字符
    NSString *rightStr=[PhoneNum substringFromIndex:PhoneNum.length-4];//右侧4个字符
    NSMutableString *centerStr=[[PhoneNum substringWithRange:NSMakeRange(4, PhoneNum.length-7)] mutableCopy] ;//中间字符
    for (int i=0; i<centerStr.length; i++) {
        [centerStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
    }
    NSMutableString *strup=[NSMutableString stringWithFormat:@"%@%@%@",leftStr,centerStr,rightStr];
    return strup;
}

/**
 *  获取系统时间戳
 */
+ (NSString *)getTimeStamp{

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]
    *1000
    ;  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%f", a]; //转为字符型
    
    return timeString;
}

/**
 *  MD5加密
 */
+ (NSString *)md5:(NSString *)str{
    
    const char *cStrValue = [str UTF8String];
    unsigned char theResult[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStrValue, (unsigned)strlen(cStrValue), theResult);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            theResult[0], theResult[1], theResult[2], theResult[3],
            theResult[4], theResult[5], theResult[6], theResult[7],
            theResult[8], theResult[9], theResult[10], theResult[11],
            theResult[12], theResult[13], theResult[14], theResult[15]];
}

/**
 *  签名验证
 */
+ (NSString *)getSign:(NSArray *)array{

    NSString *sign;
    
    for (int i=0; i<array.count; i++) {
        if (i == array.count - 1) {
            
            sign = [NSString stringWithFormat:@"%@%@",sign, kSignKey];
            
        }else{
            
            NSMutableDictionary *dic = array[i];
            NSArray *keys= [dic allKeys];
            NSString *value = [dic objectForKey:keys[0]];
            
            sign = [NSString stringWithFormat:@"%@&%@=%@",sign, keys[0], value];
        }
    }
    
    return [Global md5:sign];
}

@end
