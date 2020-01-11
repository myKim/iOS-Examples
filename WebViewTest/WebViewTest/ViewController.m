//
//  ViewController.m
//  WebViewTest
//
//  Created by 김명유 on 2020/01/05.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>
#import "WebViewManager.h"

@interface ViewController () <SFSafariViewControllerDelegate>

@end

static NSString *const urlString = @"https://naver.com";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onClickSafariViewControllerButton:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:urlString];
    WebViewManager *manager = [WebViewManager sharedInstance];
    
    [manager openURLWithSafariViewController:url fromViewController:self];
    
//    SFSafariViewController *viewController = [[SFSafariViewController alloc] initWithURL:url];
//    
//    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)onClickWebViewButton:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:urlString];
    
    
}

@end
