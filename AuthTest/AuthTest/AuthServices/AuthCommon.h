//
//  AuthCommon.h
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef AuthCommon_h
#define AuthCommon_h

#import "Utils.h"

typedef void (^CompletionHandler)(BOOL success,
                                  NSDictionary *response,
                                  NSError *error);

#endif /* AuthCommon_h */
