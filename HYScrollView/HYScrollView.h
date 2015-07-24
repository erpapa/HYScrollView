//
//  HYScrollView.h
//  scrollView图片展示-02
//
//  Created by erpapa on 15/7/23.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYScrollView : UIView
/**
 *  照片数组，初始值为空
 */
@property (copy, nonatomic) NSArray *scrollImage;
/**
 *  自动展示照片时的时间间隔，初始值为为0(不自动展示)
 */
@property(nonatomic) NSTimeInterval scrollDuration;

+ (instancetype)scrollWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame;
@end
