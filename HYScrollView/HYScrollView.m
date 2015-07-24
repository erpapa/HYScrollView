//
//  HYScrollView.m
//  scrollView图片展示-02
//
//  Created by erpapa on 15/7/23.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "HYScrollView.h"

@interface HYScrollView () <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *_imageView0;
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    NSTimer *_timer;
}
@end

@implementation HYScrollView

+ (instancetype)scrollWithFrame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadScrollView];
    }
    return self;
}

/**
 *  设置图片数组
 */
-(void)setScrollImage:(NSArray *)scrollImage{
    if (_scrollImage != scrollImage) {
        _scrollImage = [scrollImage copy];
        //设置3个imageView的image
        if (_scrollImage.count == 1){
            _imageView0.image = [_scrollImage lastObject];
            _imageView1.image = [_scrollImage lastObject];
            _imageView2.image = [_scrollImage lastObject];
        }else if (_scrollImage.count == 2){
            _imageView0.image = [_scrollImage lastObject];
            _imageView1.image = _scrollImage[0];
            _imageView2.image = [_scrollImage lastObject];
        }else if (_scrollImage.count >= 3) {
            _imageView0.image = [_scrollImage lastObject];
            _imageView1.image = _scrollImage[0];
            _imageView2.image = _scrollImage[1];
        }
        //设置pageControl
        if (self.scrollImage.count <= 8) {
            //居中显示pageControl
            CGFloat x = self.frame.size.width / 2 - (_scrollImage.count * 13) / 2;
            _pageControl.frame = CGRectMake(x, _scrollView.frame.size.height - 30, _scrollImage.count * 13, 37);
        } else {//如果图片数量大于8，则隐藏pageControl
            _pageControl.hidden = YES;
        }
        _pageControl.numberOfPages = _scrollImage.count;
    }
    
}
/**
 *  设置图片时间间隔
 *
 *  @param scrollDuration 间隔时间
 */
-(void)setScrollDuration:(NSTimeInterval)scrollDuration{
    _scrollDuration = scrollDuration;
    [self addTimer:_scrollDuration];
}

/**
 *  加载scrollView、pageControl和imageView
 */
- (void)loadScrollView{
    // 1.添加scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:(CGRect){0, 0, self.frame.size}];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, 0);
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;//代理
    [self addSubview:_scrollView];
    // 2.添加pageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    [self addSubview:_pageControl];
    // 3.添加imageView
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
    _imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(width * 0, 0, width, height)];
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(width * 1, 0, width, height)];
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
    [_scrollView addSubview:_imageView0];
    [_scrollView addSubview:_imageView1];
    [_scrollView addSubview:_imageView2];

}

/**
 *  下一页
 */
- (void)nextImage
{
    if (self.scrollImage.count < 1) {
        return;//没有图片直接返回
    }
    //设置pageControl
    if (_pageControl.currentPage == self.scrollImage.count - 1) {
        _pageControl.currentPage = 0;
    }else {
        _pageControl.currentPage++;
    }
    /**
     *  设置_imageView（_imageView2展示的是下一张图片）所以有currentPage + 1
     *  但是scrollImage图片数组是有范围的(scrollImage.count - 1)
     */
    _imageView0.image = _imageView1.image;
    _imageView1.image = _imageView2.image;
    if (_pageControl.currentPage == self.scrollImage.count - 1) {
        _imageView2.image = self.scrollImage[0];
    }else {
        _imageView2.image = self.scrollImage[_pageControl.currentPage + 1];
    }
    
}
/**
 *  上一页
 */
- (void)previousImage
{
    if (self.scrollImage.count < 1) {
        return;//没有图片直接返回
    }
    //设置pageControl
    if (_pageControl.currentPage == 0) {
        _pageControl.currentPage = self.scrollImage.count - 1;
    }else {
        _pageControl.currentPage--;
    }
    /**
     *  设置_imageView（_imageView0展示的是上一张图片）所以有currentPage - 1
     *  但是scrollImage图片数组是有范围的(scrollImage.count - 1)
     */
    _imageView2.image = _imageView1.image;
    _imageView1.image = _imageView0.image;
    if (_pageControl.currentPage == 0) {
        _imageView0.image = self.scrollImage[self.scrollImage.count - 1];
    }else {
        _imageView0.image = self.scrollImage[_pageControl.currentPage - 1];
    }
}

/**
 *  添加定时器
 */
- (void)addTimer:(NSTimeInterval)timeInterval{
    [self removeTimer];
    if (timeInterval > 0) {
        _timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(autoChangeImage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

/**
 *  移除定时器
 */
- (void)removeTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

/**
 *  定时器调用
 */
- (void)autoChangeImage
{
    [_scrollView setContentOffset:CGPointMake(2 * _scrollView.frame.size.width, 0) animated:YES];
}

/**
 *  停止拖拽scrollView
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer:self.scrollDuration];
}
/**
 *  开始拖拽scrollView
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  翻页到临界值，回到scrollView中间
 *
 *  @param scrollView 滑动的那个scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x <= 0) {
        [self previousImage];
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
    }
    if (scrollView.contentOffset.x >= 2 * scrollView.frame.size.width) {
        [self nextImage];
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
    }
}
- (void)dealloc{
    _scrollImage = nil;
    _scrollView = nil;
    _pageControl = nil;
    [_timer invalidate];
    _timer = nil;
}
@end
