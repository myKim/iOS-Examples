//
//  ViewController.m
//  CustomViewAutoLayoutTest
//
//  Created by 김명유 on 2020/04/03.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AutoLayout.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"

@interface ViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIStackView *viewContainer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.delegate = self;
    _pageControl.userInteractionEnabled = NO;
    
    CGSize size = _scrollView.frame.size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    
    FirstView *firstView = [[FirstView alloc] initWithFrame:frame];
    SecondView *secondView = [[SecondView alloc] initWithFrame:frame];
    ThirdView *thirdView = [[ThirdView alloc] initWithFrame:frame];
    
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    thirdView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [firstView.widthAnchor constraintEqualToConstant:size.width].active = YES;
    [secondView.widthAnchor constraintEqualToConstant:size.width].active = YES;
    [thirdView.widthAnchor constraintEqualToConstant:size.width].active = YES;
    
    [_viewContainer addArrangedSubview:firstView];
    [_viewContainer addArrangedSubview:secondView];
    [_viewContainer addArrangedSubview:thirdView];
    
//    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
//    for (UIGestureRecognizer *recognizer in self.window.gestureRecognizers) {
//        recognizer.delaysTouchesBegan = NO;
//    }
    self.scrollView.delaysContentTouches = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    _pageControl.currentPage = page;
}

@end
