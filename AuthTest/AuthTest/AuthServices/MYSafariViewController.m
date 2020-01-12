//
//  MYSafariViewController.m
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "MYSafariViewController.h"

@interface MYSafariViewController () <SFSafariViewControllerDelegate>

@property (nonatomic, strong, nullable) SFSafariViewController *safariViewController;

@end

@implementation MYSafariViewController

#pragma mark - Initializer

- (instancetype)initWithURL:(NSURL *)URL
{
    if ((self = [super init])) {
        [self initializeViewControllerWithURL:URL];
    }
    return self;
}

- (void)initializeViewControllerWithURL:(NSURL *)URL
{
    _safariViewController = [[SFSafariViewController alloc] initWithURL:URL];
    _safariViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    _safariViewController.delegate = self;
    
    [self displayChildViewController:_safariViewController];
}

- (void)displayChildViewController:(UIViewController *)childViewController
{
    [self addChildViewController:childViewController];
    UIView *view = self.view;
    UIView *childView = childViewController.view;
    childView.translatesAutoresizingMaskIntoConstraints = NO;
    childView.frame = view.frame;
    [view addSubview:childView];
    
    [view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:childView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:view
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:childView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:view
                                     attribute:NSLayoutAttributeTop
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

#pragma mark - SFSafariViewControllerDelegate

- (NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(nullable NSString *)title
{
    if ([self.delegate respondsToSelector:@selector(safariViewController:activityItemsForURL:title:)]) {
        return [self.delegate safariViewController:controller activityItemsForURL:URL title:title];
    }
    return nil;
}

- (NSArray<UIActivityType> *)safariViewController:(SFSafariViewController *)controller excludedActivityTypesForURL:(NSURL *)URL title:(nullable NSString *)title API_AVAILABLE(ios(11.0))
{
    if ([self.delegate respondsToSelector:@selector(safariViewController:excludedActivityTypesForURL:title:)]) {
        return [self.delegate safariViewController:controller excludedActivityTypesForURL:URL title:title];
    }
    return nil;
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    if ([self.delegate respondsToSelector:@selector(safariViewControllerDidFinish:)]) {
        [self.delegate safariViewControllerDidFinish:controller];
    }
}

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    if ([self.delegate respondsToSelector:@selector(safariViewController:didCompleteInitialLoad:)]) {
        [self.delegate safariViewController:controller didCompleteInitialLoad:didLoadSuccessfully];
    }
}

- (void)safariViewController:(SFSafariViewController *)controller initialLoadDidRedirectToURL:(NSURL *)URL API_AVAILABLE(ios(11.0))
{
    if ([self.delegate respondsToSelector:@selector(safariViewController:initialLoadDidRedirectToURL:)]) {
        [self.delegate safariViewController:controller initialLoadDidRedirectToURL:URL];
    }
}

@end
