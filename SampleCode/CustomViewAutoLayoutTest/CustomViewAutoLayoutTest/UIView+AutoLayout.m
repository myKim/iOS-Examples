//
//  UIView+AutoLayout.m
//  CustomViewAutoLayoutTest
//
//  Created by 김명유 on 2020/04/03.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

- (void)addAutoLayoutSubview:(UIView *)view
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
}

- (void)addAutoLayoutSubviews:(NSArray<UIView *> *)views
{
    for (UIView *view in views) {
        [self addAutoLayoutSubview:view];
    }
}

@end
