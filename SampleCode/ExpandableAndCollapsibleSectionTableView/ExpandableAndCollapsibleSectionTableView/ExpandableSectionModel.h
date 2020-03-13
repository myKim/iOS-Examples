//
//  ExpandableSectionModel.h
//  ExpandableAndCollapsibleSectionTableView
//
//  Created by 김명유 on 2020/03/13.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpandableSectionModel : NSObject

@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, strong) NSArray *array;

- (instancetype)initWithArray:(NSArray *)array isExpanded:(BOOL)isExpanded;

@end

NS_ASSUME_NONNULL_END
