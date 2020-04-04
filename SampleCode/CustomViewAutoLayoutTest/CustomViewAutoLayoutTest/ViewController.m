//
//  ViewController.m
//  CustomViewAutoLayoutTest
//
//  Created by 김명유 on 2020/04/03.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AutoLayout.h"

@interface ViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.delegate = self;
    _pageControl.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    _pageControl.currentPage = page;
}

@end
