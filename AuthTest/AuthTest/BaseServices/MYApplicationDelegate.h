//
//  MYApplicationDelegate.h
//  AuthTest
//
//  Created by 김명유 on 2020/01/12.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ApplicationObserving.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYApplicationDelegate : NSObject

@property (class, nonatomic, strong, readonly) MYApplicationDelegate *sharedInstance;

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_0
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
#endif

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation;

- (void)addObserver:(id<ApplicationObserving>)observer;
- (void)removeObserver:(id<ApplicationObserving>)observer;

@end

NS_ASSUME_NONNULL_END
