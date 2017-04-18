//
//  CityPickerView.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/8.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityPickerViewDelegate <NSObject>

@optional;
- (void)PickerSelectorIndixString:(NSString *)str;

@end

@interface CityPickerView : UIView


@property (nonatomic,strong)UILabel *selectLb;

@property (nonatomic,assign)id<CityPickerViewDelegate>delegate;
@end
