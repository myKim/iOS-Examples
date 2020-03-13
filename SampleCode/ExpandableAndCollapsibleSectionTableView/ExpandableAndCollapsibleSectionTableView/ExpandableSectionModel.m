//
//  ExpandableSectionModel.m
//  ExpandableAndCollapsibleSectionTableView
//
//  Created by 김명유 on 2020/03/13.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ExpandableSectionModel.h"

@implementation ExpandableSectionModel

- (instancetype)initWithArray:(NSArray *)array isExpanded:(BOOL)isExpanded
{
    if (self = [super init]) {
        _array = array;
        _isExpanded = isExpanded;
    }
    return self;
}

@end
