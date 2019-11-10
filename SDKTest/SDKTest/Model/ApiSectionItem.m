//
//  ApiSectionItem.m
//  SDKTest
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

#import "ApiSectionItem.h"

@implementation ApiSectionItem

+ (instancetype)apiSectionItemWithName:(NSString *)name apiItemList:(NSArray *)apiItemList
{
    return [[ApiSectionItem alloc] initWithName:name apiItemList:apiItemList];
}

- (instancetype)initWithName:(NSString *)name apiItemList:(NSArray *)apiItemList
{
    self = [super init];
    if (self) {
        _name = name;
        _apiItemList = apiItemList;
    }
    return self;
}

@end
