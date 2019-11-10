//
//  ApiItem.m
//  SDKTest
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

#import "ApiItem.h"

@implementation ApiItem

+ (instancetype)apiItemWithName:(NSString *)name desc:(NSString *)desc target:(id)target selector:(SEL)selector
{
    return [[ApiItem alloc] initWithName:name desc:desc target:target selector:selector];
}

- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc target:(id)target selector:(SEL)selector
{
    self = [super init];
    if (self) {
        _name = name;
        _desc = desc;
        _target = target;
        _selector = selector;
    }
    return self;
}

- (void)setTaget:(id)target selector:(SEL)selector
{
    self.target = target;
    self.selector = selector;
}

- (void)triggerAction
{
    if ([self.target respondsToSelector:self.selector]) {
        IMP imp = [self.target methodForSelector:self.selector];
        void (* func)(id, SEL, ApiItem *) = (void *)imp;
        func(self.target, self.selector, self);
    }
}

@end
