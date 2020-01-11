//
//  WebViewManager.h
//  WebViewTest
//
//  Created by 김명유 on 2020/01/05.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebViewManager : NSObject

@property (class, nonatomic, readonly, strong) WebViewManager *sharedInstance
NS_SWIFT_NAME(shared);

- (void)openURLWithSafariViewController:(NSURL *)url
                     fromViewController:(UIViewController *)fromViewController;

@end
