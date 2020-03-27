//
//  CircularTransition.h
//  CircularTransitionAnimation
//
//  Created by 김명유 on 2020/03/27.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

// https://www.youtube.com/watch?v=B9sH_VxPPo4
// iOS Swift Tutorial: Create a Circular Transition Animation (Custom UIViewController Transitions)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CircularTransitionMode)
{
    CircularTransitionModePresent,
    CircularTransitionModeDismiss,
    CircularTransitionModePop,
};

NS_ASSUME_NONNULL_BEGIN

@interface CircularTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *circle;
@property (nonatomic, assign) CGPoint startingPoint;
@property (nonatomic, copy) UIColor *circleColor;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CircularTransitionMode transitionMode;

@end

NS_ASSUME_NONNULL_END
