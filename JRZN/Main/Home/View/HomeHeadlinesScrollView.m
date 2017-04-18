//
//  HomeHeadlinesScrollView.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/25.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "HomeHeadlinesScrollView.h"

//每隔多长时间滚动一次
static CGFloat const RollDuration = 3.0f;

@interface HomeHeadlinesScrollView ()
{
    UIView *_firstView;
    UIView *_middleView;
    UIView *_lastView;
    
    float _viewWidth;
    float _viewHeight;
    
    NSTimer *_autoScrollTimer;
    
    UITapGestureRecognizer *_tap;
}

@end

@implementation HomeHeadlinesScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.height = 78;
        
        _viewWidth = self.bounds.size.width;
        _viewHeight = self.bounds.size.height;
        
        //设置scrollview
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(_viewWidth, _viewHeight*3);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        _scrollView.scrollEnabled = false;
        
        //设置单击手势
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        [_scrollView addGestureRecognizer:_tap];
    }
    return self;
}

#pragma mark 单击手势
-(void)handleTap:(UITapGestureRecognizer*)sender
{
    //    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
    //        [_delegate didClickPage:self atIndex:_currentPage+1];
    //    }
    
    //    if ([self.delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
    //        [self.delegate didClickPage:self atIndex:_currentPage+1];
    //    }
}

#pragma mark 设置imageViewAry
-(void)setImageViewAry:(NSMutableArray *)imageViewAry
{
    if (imageViewAry) {
        _imageViewAry = imageViewAry;
        _currentPage = 0; //默认为第0页
    }
    
    [self reloadData];
}

#pragma mark 刷新view页面
-(void)reloadData
{
    [_firstView removeFromSuperview];
    [_middleView removeFromSuperview];
    [_lastView removeFromSuperview];
    
    //从数组中取到对应的图片view加到已定义的三个view中
    if (_currentPage==0) {
        _firstView = [_imageViewAry lastObject];
        _middleView = [_imageViewAry objectAtIndex:_currentPage];
        _lastView = [_imageViewAry objectAtIndex:_currentPage+1];
    }
    else if (_currentPage == _imageViewAry.count-1)
    {
        _firstView = [_imageViewAry objectAtIndex:_currentPage-1];
        _middleView = [_imageViewAry objectAtIndex:_currentPage];
        _lastView = [_imageViewAry firstObject];
    }
    else
    {
        _firstView = [_imageViewAry objectAtIndex:_currentPage-1];
        _middleView = [_imageViewAry objectAtIndex:_currentPage];
        _lastView = [_imageViewAry objectAtIndex:_currentPage+1];
    }
    
    //设置三个view的frame，加到scrollview上
    _firstView.frame = CGRectMake(0, 0, _viewWidth, _viewHeight);
    _middleView.frame = CGRectMake(0, _viewHeight, _viewWidth, _viewHeight);
    _lastView.frame = CGRectMake(0, _viewHeight*2, _viewWidth, _viewHeight);
    [_scrollView addSubview:_firstView];
    [_scrollView addSubview:_middleView];
    [_scrollView addSubview:_lastView];
    
    //显示中间页
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:NO];
    _firstView.y = -_viewHeight;
    _middleView.y = 0;
//    [_scrollView setContentOffset:CGPointMake(0, _viewHeight) animated:YES];
//        _scrollView.contentOffset = CGPointMake(0, _viewHeight);
    [UIView commitAnimations];
    
}



#pragma mark 自动滚动
-(void)shouldAutoShow:(BOOL)shouldStart
{
    if (shouldStart) //开启自动翻页
    {
        if (!_autoScrollTimer) {
            _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:RollDuration target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
        }
    }
    else //关闭自动翻页
    {
        if (_autoScrollTimer.isValid) {
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
        }
    }
}

#pragma mark 展示下一页
-(void)autoShowNextImage
{
    if (_currentPage == _imageViewAry.count-1) {
        _currentPage = 0;
    }else{
        _currentPage ++;
    }
    
    [self reloadData];
}

@end
