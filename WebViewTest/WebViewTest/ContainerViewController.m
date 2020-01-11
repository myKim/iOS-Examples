//
//  ContainerViewController.m
//  WebViewTest
//
//  Created by 김명유 on 2020/01/05.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ContainerViewController.h"

@implementation ContainerViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ([self.delegate respondsToSelector:@selector(viewControllerDidDisappear:animated:)]) {
        [self.delegate viewControllerDidDisappear:self animated:animated];
    }
}

- (void)displayChildController:(UIViewController *)childViewController
{
    [self addChildViewController:childViewController];
    UIView *view = self.view;
    UIView *childView = childViewController.view;
    childView.translatesAutoresizingMaskIntoConstraints = NO;
    childView.frame = view.frame;
    [view addSubview:childView];
    
    [view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:childView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:view
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:childView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:view
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:childView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:view
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:childView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:view
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:0.0],
    ]];
    
    [childViewController didMoveToParentViewController:self];
}

@end
