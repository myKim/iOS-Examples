//
//  ViewController.m
//  PageControlTurorial
//
//  Created by 김명유 on 2020/04/02.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController
{
    NSArray *_array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = @[@"0", @"1", @"2"];
    
    _pageControl.numberOfPages = _array.count;
    for (int i=0; i<_array.count; i++) {
        CGRect frame = CGRectMake(0, 0, 0, 0);
        frame.origin.x = _scrollView.frame.size.width * i;
        frame.size = _scrollView.frame.size;
        
        UIView *view = [[UIView alloc] initWithFrame:frame];
        UIColor *backgroundColor = UIColor.blueColor;
        switch (i) {
            case 0: {
                backgroundColor = UIColor.blueColor;
                break;
            }
            case 1: {
                backgroundColor = UIColor.greenColor;
                break;
            }
            case 2: {
                backgroundColor = UIColor.redColor;
                break;
            }
            default: 
                break;
        }
        
        view.backgroundColor = backgroundColor;
        
        [_scrollView addSubview:view];
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _array.count,
                                         _scrollView.frame.size.height);
    
    _scrollView.delegate = self;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    _pageControl.currentPage = page;
    
}

@end
