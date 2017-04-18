//
//  NSString+Extension.m
//  HYJFIOS
//
//  Created by 曾国锐 on 15/12/28.
//  Copyright © 2015年 sztg. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (NSString *)md5:(NSString *)str{

    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//校验用户手机号码
- (BOOL)validateUserPhone:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^1[3|4|5|7|8][0-9][0-9]{8}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    
    return NO;
    
    
}

/**
 * 检验邮箱
 */
-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

//时间戳转换
- (NSString *)timeWithDate:(NSString *)timeDate{
    
    NSString *str= timeDate;//时间戳
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    DDLog(@"%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

//时间转换
- (NSString*)stringWithTime:(NSString *)time
{
    if ( time == nil )
    {
        return nil;
    }
    //获得返回的时间戳
    long long  returnTime = [time longLongValue]/1000;
    
    //创建时间格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //获得当前的时间
    NSDate *date = [NSDate date];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //d得到当前的日期的凌晨12点
    NSString *noTime = [NSString stringWithFormat:@"%@ 00:00:00",[formatter stringFromDate:date]];
    
    //NSLog(@"%@",noTime);
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //把获得的当前日期的凌晨12点转化为nsdate
    NSDate *nowDay = [formatter dateFromString:noTime];
    
   // IWLog(@"%@",nowDay);
    //获得当前的时间戳
    long nowTime =  [nowDay timeIntervalSince1970];
    
   // IWLog(@"%ld",nowTime);
    
    //获得相差多少秒
    long long b = nowTime-returnTime;
    
   // IWLog(@"%lld",b);
    //把相差的时间戳转化为多少天相差
    long long   c = b/(60*60*24);
    
   // IWLog(@"%lld",c);
    
    //把返回的时间戳转化为时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:returnTime];
    
    if ( c < 1 )
    {
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
        NSString *nowYear = [formatter stringFromDate:date];
        
        NSString *lastYear  = [formatter stringFromDate:confromTimesp];
        
        if ([nowYear isEqualToString:lastYear]) {
            
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
        
        NSString *s ;
        
        s = [NSString stringWithFormat:@"%lld天前",c+1];
        
        DDLog(@"%lld天前%@",c,s);
        
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

//base64图片转换
- (NSString*)encodeURL:(NSString *)string{
    
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
    if (newString) {
        
      return newString;
    }
      return @"";
}

//只显示银行卡的前四位和后四位 中间用@"**"标示
- (NSString*)hiddeBankNumber:(NSString *)bankNum{
    NSString *leftStr=[bankNum substringToIndex:4];//左侧4个字符
    NSString *rightStr=[bankNum substringFromIndex:bankNum.length-4];//右侧4个字符
    NSMutableString *centerStr=[[bankNum substringWithRange:NSMakeRange(4, bankNum.length-8)] mutableCopy] ;//中间字符
    for (int i=0; i<centerStr.length; i++) {
        [centerStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
    }
    NSMutableString *strup=[NSMutableString stringWithFormat:@"%@%@%@",leftStr,centerStr,rightStr];
    return strup;
}

/**
 *  显示手机号的前三位和后四位
 */
- (NSString*)hiddePhoneNumber:(NSString *)PhoneNum{

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
 *  显示身份证的前三位和后四位
 */
- (NSString*)hiddeIdCardNumber:(NSString *)IdCardNum{

    NSString *leftStr=[IdCardNum substringToIndex:3];//左侧4个字符
    NSString *rightStr=[IdCardNum substringFromIndex:IdCardNum.length-4];//右侧4个字符
    NSMutableString *centerStr=[[IdCardNum substringWithRange:NSMakeRange(4, IdCardNum.length-7)] mutableCopy] ;//中间字符
    for (int i=0; i<centerStr.length; i++) {
        [centerStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
    }
    NSMutableString *strup=[NSMutableString stringWithFormat:@"%@%@%@",leftStr,centerStr,rightStr];
    return strup;
}

/**
 *  显示银行卡后四位
 */
- (NSString*)hiddeBankCardNumber:(NSString *)bankNum{
    
    NSString *rightStr=[bankNum substringFromIndex:bankNum.length-4];//右侧4个字符
    
    NSMutableString *strup=[NSMutableString stringWithFormat:@"**** **** **** %@",rightStr];
    return strup;
}

/**
 *	@brief	正则校验-身份证号码
 *
 *	@param 	value 	输入身份证号码
 *
 *	@return	返回是否合法身份证号（BOOL）
 */
- (BOOL)validateIdCard:(NSString *)value
{
    NSString *valueRegex1 = @"^((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|81|82|91)\\d{4})((((19|20)(([02468][048])|([13579][26]))0229))|((20[0-9][0-9])|(19[0-9][0-9]))((((0[1-9])|(1[0-2]))((0[1-9])|(1\\d)|(2[0-8])))|((((0[1,3-9])|(1[0-2]))(29|30))|(((0[13578])|(1[02]))31))))((\\d{3}(x|X))|(\\d{4}))";
    NSPredicate *valueTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", valueRegex1];
    NSString *valueRegex2 = @"^((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|81|82|91)\\d{4})((((([02468][048])|([13579][26]))0229))|([0-9][0-9])((((0[1-9])|(1[0-2]))((0[1-9])|(1\\d)|(2[0-8])))|((((0[1,3-9])|(1[0-2]))(29|30))|(((0[13578])|(1[02]))31))))(\\d{3})";
    NSPredicate *valueTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", valueRegex2];
    return [valueTest1 evaluateWithObject:value] || [valueTest2 evaluateWithObject:value];
}

/**
 *  计算缓存大小
 */
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

/**
 *  校验银行卡
 */
- (BOOL)checkCardNo:(NSString*)cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

@end
