//
//  Auth.h
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AuthCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface Auth : NSObject

+ (void)showLoginWithCompletionHandler:(CompletionHandler)completionHandler;
+ (void)loginViaAuthProviderCode:(NSString *)code
               completionHandler:(CompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
