//
//  Utils.h
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+ (BOOL)isRegisteredURLScheme:(NSString *)URLScheme;

+ (UIViewController *)topMostViewController;

@end

NS_ASSUME_NONNULL_END
