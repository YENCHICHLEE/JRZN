//
//  ZGRNavigationController.h
//  JRZN
//
//  Created by 曾国锐 on 16/5/31.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PopAnimationType){
    PopAnimationTypeFromeBehind = 0, // 动画效果从后往前  默认效果
    PopAnimationTypeliner = 1, // 动画效果从左向右平滑
};
@interface ZGRNavigationController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, assign) PopAnimationType popAnimationType;
@property (nonatomic,assign) BOOL canDragBack;
@end
