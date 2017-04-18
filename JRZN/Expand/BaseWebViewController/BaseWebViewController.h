//
//  BaseWebViewController.h
//  JRZN
//
//  Created by 曾国锐 on 16/5/11.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  网页base（直接调用）

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController

/*
 *  静态网址
 */
@property (nonatomic, copy) NSString *webViewStaticApi;

/*
 *  动态网址
 */
@property (nonatomic, copy) NSString *webViewDynamicApi;

@end
