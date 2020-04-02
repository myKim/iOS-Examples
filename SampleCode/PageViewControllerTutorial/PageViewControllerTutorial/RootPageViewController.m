//
//  RootPageViewController.m
//  PageViewControllerTutorial
//
//  Created by 김명유 on 2020/04/02.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "RootPageViewController.h"

@interface RootPageViewController () <UIPageViewControllerDataSource>

@end

@implementation RootPageViewController
{
    NSArray *_viewControllerList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    
    self.dataSource = self;
    
    UIViewController *firstViewController = _viewControllerList.firstObject;
    [self setViewControllers:@[firstViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

- (void)initializeData
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *firstViewController = [storyBoard instantiateViewControllerWithIdentifier:@"GreenVC"];
    UIViewController *secondViewController = [storyBoard instantiateViewControllerWithIdentifier:@"OrangeVC"];
    UIViewController *thirdViewController = [storyBoard instantiateViewControllerWithIdentifier:@"BrownVC"];
    
    _viewControllerList = @[firstViewController, secondViewController, thirdViewController];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [_viewControllerList indexOfObject:viewController];
    
    NSInteger previousIndex = index - 1;
    
    if (previousIndex < 0 || _viewControllerList.count <= previousIndex) {
        return nil;
    }
    
    return _viewControllerList[previousIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [_viewControllerList indexOfObject:viewController];
    
    NSInteger nextIndex = index + 1;
    
    if (nextIndex < 0 || _viewControllerList.count <= nextIndex) {
        return nil;
    }
    
    return _viewControllerList[nextIndex];
}

@end
