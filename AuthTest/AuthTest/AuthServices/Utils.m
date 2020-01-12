//
//  Utils.m
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "Utils.h"
#import "AuthCommon.h"

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

+ (UIWindow *)findWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window == nil || window.windowLevel != UIWindowLevelNormal) {
        for (window in [UIApplication sharedApplication].windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }

    // Find active key window from UIScene
    if (@available(iOS 13.0, tvOS 13, *)) {
        NSSet *scenes = [[UIApplication sharedApplication] valueForKey:@"connectedScenes"];
        for (id scene in scenes) {
            if (window) {
                break;
            }

            id activationState = [scene valueForKeyPath:@"activationState"];
            BOOL isActive = activationState != nil && [activationState integerValue] == 0;
            if (isActive) {
                Class WindowScene = NSClassFromString(@"UIWindowScene");
                if ([scene isKindOfClass:WindowScene]) {
                    NSArray<UIWindow *> *windows = [scene valueForKeyPath:@"windows"];
                    for (UIWindow *w in windows) {
                        if (w.isKeyWindow) {
                            window = w;
                            break;
                        }
                    }
                }
            }
        }
    }
    return window;
}

+ (UIViewController *)topMostViewController
{
    UIWindow *keyWindow = [self findWindow];
    // SDK expects a key window at this point, if it is not, make it one
    if (keyWindow != nil && !keyWindow.isKeyWindow) {
        [keyWindow makeKeyWindow];
    }

    UIViewController *topController = keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

@end
