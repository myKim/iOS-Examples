//
//  AuthManager.m
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "AuthManager.h"
#import "MYSafariViewController.h"
#import "ApplicationObserving.h"
#import "BaseServices.h"

static NSString *const appScheme = @"myung120scheme";

@interface AuthManager() <MYSafariViewControllerDelegate, ApplicationObserving>

@property (nonatomic, strong, nullable) CompletionHandler webLoginHandler;
@property (nonatomic, strong, nullable) MYSafariViewController *safariViewController;

@end

@implementation AuthManager

#pragma mark - Initializer

+ (instancetype)sharedAuthManager
{
    static AuthManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Public Methods

- (void)loginViaAuthProviderCode:(NSString *)code
               completionHandler:(CompletionHandler)completionHandler
{
    if ([code isEqualToString:@"google"]) {
        [self requestLoginViaGoogleWithCompletionHandler:completionHandler];
        return;
    } else if ([code isEqualToString:@"facebook"]) {
        [self requestLoginViaFacebookWithCompletionHandler:completionHandler];
        return;
    } else if ([code isEqualToString:@"guest"]) {
        [self requestLoginViaGuestWithCompletionHandler:completionHandler];
        return;
    }
    
    NSError *error = [NSError errorWithDomain:@"Invalid Auth Provider Code" code:1000 userInfo:nil];
    completionHandler(NO, nil, error);
}

#pragma mark - Login AuthProviderCode

- (void)requestLoginViaGoogleWithCompletionHandler:(CompletionHandler)completionHandler
{
    [self requestLoginGoogleWithCompletionHandler:^(BOOL success, NSDictionary *response, NSError *error) {
        NSString *authnToken = nil;
        NSDictionary *result = nil;
        
        if (success) {
            authnToken = [response objectForKey:@"authn_token"];
            NSString *loginResult = [NSString stringWithFormat:@"GoogleLoginWithToken[%@]", authnToken];
            result = @{@"result":loginResult};
        }
        
        completionHandler(success, result, error);
    }];
}

- (void)requestLoginViaFacebookWithCompletionHandler:(CompletionHandler)completionHandler
{
    [self requestLoginFacebookWithCompletionHandler:^(BOOL success, NSDictionary *response, NSError *error) {
        NSString *authnToken = nil;
        NSDictionary *result = nil;
        
        if (success) {
            authnToken = [response objectForKey:@"authn_token"];
            NSString *loginResult = [NSString stringWithFormat:@"FacebookLoginWithToken[%@]", authnToken];
            result = @{@"result":loginResult};
        }
        
        completionHandler(success, result, error);
    }];
}

- (void)requestLoginViaGuestWithCompletionHandler:(CompletionHandler)completionHandler
{
    [self requestLoginGuestWithCompletionHandler:^(BOOL success, NSDictionary *response, NSError *error) {
        NSString *authnToken = nil;
        NSDictionary *result = nil;
        
        if (success) {
            authnToken = [response objectForKey:@"authn_token"];
            NSString *loginResult = [NSString stringWithFormat:@"GuestLoginWithToken[%@]", authnToken];
            result = @{@"result":loginResult};
        }
        
        completionHandler(success, result, error);
    }];
}

#pragma mark - Login via AuthProviderCode

- (void)requestLoginGoogleWithCompletionHandler:(CompletionHandler)completionHandler
{
//    NSString *string = @"http://34.84.171.142:9090/test/page-1?redirect_url=myung120scheme://auth/authntoken";
//    NSString *string = @"http://34.84.171.132:9090/test/page-2?redirect_url=https://naver.com";
    NSString *string = @"http://34.84.171.132:9090/test/page-1?redirect_url=myung120scheme://auth/authntoken";
//    NSString *string = @"myung120scheme://auth/authntoken";
    NSURL *URL = [NSURL URLWithString:string];
    [self openLoginWebURL:URL completionHandler:completionHandler];
}

- (void)requestLoginFacebookWithCompletionHandler:(CompletionHandler)completionHandler
{
    NSURL *URL = [NSURL URLWithString:@"https://facebook.com"];
    [self openLoginWebURL:URL completionHandler:completionHandler];
}

- (void)requestLoginGuestWithCompletionHandler:(CompletionHandler)completionHandler
{
    completionHandler(YES, @{@"authn_token":@"guest1234"}, nil);
}

#pragma mark - Open LoginWeb

- (void)openLoginWebURL:(NSURL *)URL
      completionHandler:(CompletionHandler)completionHandler
{
    BOOL isRegisteredScheme = [Utils isRegisteredURLScheme:appScheme];
    if (!isRegisteredScheme) {
        NSError *error = [NSError errorWithDomain:@"Not registered URLScheme" code:1000 userInfo:nil];
        completionHandler(NO, nil, error);
        return;
    }
    
    self.webLoginHandler = [completionHandler copy];
    [[MYApplicationDelegate sharedInstance] addObserver:self];
    
    Class SFSafariViewControllerClass = NSClassFromString(@"SFSafariViewController");
    if (SFSafariViewControllerClass) {
        [self openURLWithSafariViewController:URL fromViewController:nil];
    } else {
        [self openURL:URL];
    }
}

#pragma mark - Internal Methods

- (void)openURL:(NSURL *)URL
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:URL];
        }
    });
}

- (void)openURLWithSafariViewController:(NSURL *)URL
                     fromViewController:(UIViewController *)fromViewController
{
    UIViewController *parentViewController = fromViewController ?: [Utils topMostViewController];
    
    self.safariViewController = [[MYSafariViewController alloc] initWithURL:URL];
    self.safariViewController.delegate = self;
    
    [parentViewController presentViewController:self.safariViewController animated:YES completion:nil];
}

#pragma mark - ApplicationObserving

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    [self completeWebLoginAuthenticationWithURL:url];
    return YES;
}

#pragma mark - Complete Authentication
- (void)completeWebLoginAuthenticationWithURL:(NSURL *)url
{
    if (_safariViewController) {
        [_safariViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (!_webLoginHandler) {
        return;
    }
    
    CompletionHandler handler = self.webLoginHandler;
    self.webLoginHandler = nil;
    
    NSString *token = url.parameterString;
    if (!token) {
        NSError *error = [NSError errorWithDomain:@"response token error"
                                             code:1000
                                         userInfo:nil];
        handler(NO, nil, error);
        return;
    }
    
    NSDictionary *result = @{@"authn_token":token};
    handler(YES, result, nil);
}

@end
