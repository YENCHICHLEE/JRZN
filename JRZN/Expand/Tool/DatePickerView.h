//
//  DatePickerView.h
//  DatePickerDemo
//
//  Created by 曾国锐 on 16/6/12.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

@optional;
- (void)datePickerSelectorIndixString:(NSString *)str;

@end

@interface DatePickerView : UIView


@property (nonatomic,strong)UILabel *selectLb;

@property (nonatomic,assign)id<DatePickerViewDelegate>delegate;

@end
