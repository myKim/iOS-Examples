//
//  Auth.m
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "Auth.h"
#import "AuthManager.h"

@implementation Auth

#pragma mark - Public Methods

+ (void)showLoginWithCompletionHandler:(CompletionHandler)completionHandler
{
    
}

+ (void)loginViaAuthProviderCode:(NSString *)code
               completionHandler:(CompletionHandler)completionHandler
{
    [[AuthManager sharedAuthManager] loginViaAuthProviderCode:code
                                            completionHandler:completionHandler];
}

@end
