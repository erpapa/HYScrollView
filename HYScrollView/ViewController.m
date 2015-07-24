//
//  ViewController.m
//  HYScrollView
//
//  Created by erpapa on 15/7/24.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "ViewController.h"
#import "HYScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"img_%02d",i]];
        [array addObject:img];
    }
    //两种初始化方法
    //HYScrollView *view = [HYScrollView scrollWithFrame:CGRectMake(10, 0, 300, 130)];
    HYScrollView *view = [[HYScrollView alloc] initWithFrame:CGRectMake(10, 20, 300, 130)];
    view.scrollImage = array;//图片数组
    view.scrollDuration = 1.5;//自动展示时的间隔时间（默认为0，不自动展示）
    [self.view addSubview:view];
}


@end
