# HYScrollView
    
![](/showImage.gif)
    
    使用方法：
    //两种初始化方法
    //HYScrollView *view = [HYScrollView scrollWithFrame:CGRectMake(10, 0, 300, 130)];
    HYScrollView *view = [[HYScrollView alloc] initWithFrame:CGRectMake(10, 20, 300, 130)];
    view.scrollImage = array;//赋值图片数组
    view.scrollDuration = 1.5;//自动切换图片时间间隔（默认为0，不自动切换）
    [self.view addSubview:view];
    
