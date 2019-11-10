//
//  ApiItem.h
//  SDKTest
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApiItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) id target;

+ (instancetype)apiItemWithName:(NSString *)name desc:(NSString *)desc target:(id)target selector:(SEL)selector;
- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc target:(id)target selector:(SEL)selector;

- (void)setTaget:(id)target selector:(SEL)selector;
- (void)triggerAction;

@end

NS_ASSUME_NONNULL_END
