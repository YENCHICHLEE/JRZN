//
//  HomeHeadlinesScrollView.h
//  JRZN
//
//  Created by 曾国锐 on 16/5/25.
//  Copyright © 2016年 曾国锐. All rights reserved.
//  头条新闻-滑动模块

#import <UIKit/UIKit.h>

@protocol HomeHeadlinesScrollViewDelegate <NSObject>


//- (void)didClickPage:(HomeHeadlinesScrollView *)view atIndex:(NSInteger)index;

@end

@interface HomeHeadlinesScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

-(void)shouldAutoShow:(BOOL)shouldStart;

@end
