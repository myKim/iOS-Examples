//
//  AuthManager.m
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "AuthManager.h"

static NSString *const appScheme = @"myung120scheme";

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
    NSURL *URL = [NSURL URLWithString:@"https://google.com"];
    [self openLoginWebURL:URL];
}

- (void)requestLoginFacebookWithCompletionHandler:(CompletionHandler)completionHandler
{
    NSURL *URL = [NSURL URLWithString:@"https://facebook.com"];
    [self openLoginWebURL:URL];
}

- (void)requestLoginGuestWithCompletionHandler:(CompletionHandler)completionHandler
{
    BOOL isRegisteredScheme = [Utils isRegisteredURLScheme:appScheme];
    
    completionHandler(YES, @{@"authn_token":@"guest1234"}, nil);
}

#pragma mark - Open LoginWeb

- (void)openLoginWebURL:(NSURL *)URL
{
    [self openURL:URL];
}

#pragma mark - Internal Methods

- (void)openURL:(NSURL *)URL
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL
                                               options:@{}
                                     completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:URL];
        }
    });
}

@end
