//
//  ApplicationObserving.h
//  AuthTest
//
//  Created by 김명유 on 2020/01/12.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApplicationObserving <NSObject>

@optional
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation;

@end
