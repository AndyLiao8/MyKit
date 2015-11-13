//
//  ViewController.m
//  SliderDemo
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "ViewController.h"
#import "TestCollectionViewCell.h"
#import "Masonry.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    NSArray *_arrImages;
    UIScrollView *_scrollView;
    NSInteger _currentPage;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    float _scrollWidth;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrImages = @[@"bg_introduction2",
                   @"bg_introduction1",
                   @"bg_introduction3",
                   @"bg_introduction4"];
    _currentPage = 0;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    float statusH = 20;
    _scrollWidth = rect.size.width;
    float imgH = rect.size.height - statusH;
    NSInteger count = 0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, statusH, _scrollWidth, imgH)];
    _scrollView.contentSize = CGSizeMake([_arrImages count]*_scrollWidth,imgH);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    //创建
    for (NSString *iname in _arrImages) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((count++)*_scrollWidth, statusH, _scrollWidth, imgH)];
        imageView.image = [UIImage imageNamed:iname];
        [_scrollView addSubview:imageView];
    }
    [self.view addSubview:_scrollView];
    
    //加点
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    _pageControl.numberOfPages = [_arrImages count];
    _pageControl.tintColor = [UIColor redColor];
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(20);
    }];
    [self addTimer];
}

-(void)nextImage{
    float offsetLeft = 0;
    if(_currentPage>=[_arrImages count]){
        offsetLeft = 0;
        _currentPage = 0;
    }else{
        offsetLeft = _currentPage*_scrollWidth;
    }
    _pageControl.currentPage = _currentPage++;
    _scrollView.contentOffset = CGPointMake(offsetLeft, 0);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _currentPage = (_scrollView.contentOffset.x+_scrollWidth/2)/_scrollWidth;
    [self addTimer];
    [self nextImage];
}

-(void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
