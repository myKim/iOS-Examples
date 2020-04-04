//
//  UIView+AutoLayout.h
//  CustomViewAutoLayoutTest
//
//  Created by 김명유 on 2020/04/03.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AutoLayout)

- (void)addAutoLayoutSubview:(UIView *)view;
- (void)addAutoLayoutSubviews:(NSArray<UIView *> *)views;

@end

NS_ASSUME_NONNULL_END
