//
//  ApiSectionItem.h
//  SDKTest
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApiSectionItem : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *apiItemList;

+ (instancetype)apiSectionItemWithName:(NSString *)name apiItemList:(NSArray *)apiItemList;
- (instancetype)initWithName:(NSString *)name apiItemList:(NSArray *)apiItemList;
@end

NS_ASSUME_NONNULL_END
