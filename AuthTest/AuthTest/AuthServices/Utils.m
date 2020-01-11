//
//  Utils.m
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (BOOL)isRegisteredURLScheme:(NSString *)URLScheme
{
    static dispatch_once_t fetchBundleOnce;
    static NSArray *types = nil;

    dispatch_once(&fetchBundleOnce, ^{
        types = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleURLTypes"];
    });
    
    for (NSDictionary *type in types) {
        NSArray *schemes = [type valueForKey:@"CFBundleURLSchemes"];
        if ([schemes containsObject:URLScheme]) {
            return YES;
        }
    }
    return NO;
}

@end
