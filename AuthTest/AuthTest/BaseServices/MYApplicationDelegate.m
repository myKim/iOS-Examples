//
//  MYApplicationDelegate.m
//  AuthTest
//
//  Created by 김명유 on 2020/01/12.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "MYApplicationDelegate.h"


@interface MYApplicationDelegate()

@property (nonatomic, strong) NSHashTable<id<ApplicationObserving>> *observers;

@end


@implementation MYApplicationDelegate

#pragma mark - Initializers

+ (MYApplicationDelegate *)sharedInstance
{
    static MYApplicationDelegate *sharedInstance;
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

#pragma mark - From UIApplicationDelegate

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_0
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if (@available(iOS 9.0, *)) {
        return [self application:app
                         openURL:url
               sourceApplication:options[UIApplicationLaunchOptionsSourceApplicationKey]
                      annotation:options[UIApplicationLaunchOptionsAnnotationKey]];
    }
    return NO;
}
#endif

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL handled = NO;
    
    NSArray<id<ApplicationObserving>> *observers = [_observers allObjects];
    for (id<ApplicationObserving> observer in observers) {
        if ([observer respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            if ([observer application:application
                              openURL:url
                    sourceApplication:sourceApplication
                           annotation:annotation]) {
                handled = YES;
            }
        }
    }
    
    return handled;
}

#pragma mark - ApplicationObserving

- (void)addObserver:(id<ApplicationObserving>)observer
{
    if (![_observers containsObject:observer]) {
        [self.observers addObject:observer];
    }
}

- (void)removeObserver:(id<ApplicationObserving>)observer
{
    if ([_observers containsObject:observer]) {
        [self.observers removeObject:observer];
    }
}

@end
