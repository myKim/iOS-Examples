//
//  WebViewManager.m
//  WebViewTest
//
//  Created by 김명유 on 2020/01/05.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "WebViewManager.h"
#import <WebKit/WebKit.h>
#import <SafariServices/SafariServices.h>
#import "ContainerViewController.h"

@implementation WebViewManager {
    UIViewController *_safariViewController;
}

+ (WebViewManager *)sharedInstance
{
    static WebViewManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        sharedInstance = [[WebViewManager alloc] init];
    });
    return sharedInstance;
}

- (void)openURLWithSafariViewController:(NSURL *)url
                     fromViewController:(UIViewController *)fromViewController
{
    UIViewController *parent = fromViewController ?: nil;
    
    if (parent == nil) {
        NSLog(@"Not exist parent view controller");
        return;
    }
    
    ContainerViewController *container = [[ContainerViewController alloc] init];
    container.delegate = self;
    
    if (parent.transitionCoordinator != nil) {
        [parent.transitionCoordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self->_safariViewController = [[SFSafariViewController alloc] initWithURL:url];
            
            self->_safariViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [container displayChildController:_safariViewController];
            [parent presentViewController:container
                                 animated:YES
                               completion:nil];
        }];
    } else {
        _safariViewController = [[SFSafariViewController alloc] initWithURL:url];
        
        _safariViewController.modalPresentationStyle = UIModalPresentationPageSheet;
//        [container displayChildController:_safariViewController];
        [parent presentViewController:_safariViewController
                             animated:YES
                           completion:nil];
    }
    
}

@end
