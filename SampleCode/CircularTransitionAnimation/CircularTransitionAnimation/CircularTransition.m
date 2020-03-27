//
//  CircularTransition.m
//  CircularTransitionAnimation
//
//  Created by 김명유 on 2020/03/27.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "CircularTransition.h"

@implementation CircularTransition

#pragma mark - Intializers

- (instancetype)init
{
    if (self = [super init]) {
        _circle = [[UIView alloc] init];
        _startingPoint = CGPointZero;
        _circleColor = UIColor.whiteColor;
        _duration = 1.0;
        _transitionMode = CircularTransitionModePresent;
    }
    return self;
}

#pragma mark - Getter and Setter

- (void)setStartingPoint:(CGPoint)startingPoint
{
    _startingPoint = startingPoint;
    _circle.center = startingPoint;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}


- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    
    if (_transitionMode == CircularTransitionModePresent) {
        UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        CGPoint viewCenter = presentedView.center;
        CGSize viewSize = presentedView.frame.size;
        
        _circle = [[UIView alloc] init];
        
        _circle.frame = [self frameForCircleWithViewCenter:viewCenter size:viewSize startPoint:_startingPoint];
        
        _circle.layer.cornerRadius = _circle.frame.size.height / 2;
        _circle.center = _startingPoint;
        _circle.backgroundColor = _circleColor;
        _circle.transform = CGAffineTransformMakeScale(0.001, 0.001);
        [containerView addSubview:_circle];
        
        presentedView.center = _startingPoint;
        presentedView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        presentedView.alpha = 0;
        [containerView addSubview:presentedView];
        
        [UIView animateWithDuration:_duration animations:^{
            self.circle.transform = CGAffineTransformIdentity;
            presentedView.transform = CGAffineTransformIdentity;
            presentedView.alpha = 1;
            presentedView.center = viewCenter;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    } else {
        NSString *transitionModeKey = (_transitionMode == CircularTransitionModePop) ? UITransitionContextToViewKey : UITransitionContextFromViewKey;
        
        UIView *returningView = [transitionContext viewForKey:transitionModeKey];
        CGPoint viewCenter = returningView.center;
        CGSize viewSize = returningView.frame.size;
        
        _circle.frame = [self frameForCircleWithViewCenter:viewCenter size:viewSize startPoint:_startingPoint];
        
        _circle.layer.cornerRadius = _circle.frame.size.height / 2;
        _circle.center = _startingPoint;
        
        [UIView animateWithDuration:_duration animations:^{
            self.circle.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returningView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returningView.center = self.startingPoint;
            returningView.alpha = 0;
            
            if (self.transitionMode == CircularTransitionModePop) {
                [containerView insertSubview:returningView belowSubview:returningView];
                [containerView insertSubview:self.circle belowSubview:returningView];
            }
            
        } completion:^(BOOL finished) {
            returningView.center = viewCenter;
            [returningView removeFromSuperview];
            
            [self.circle removeFromSuperview];
            
            [transitionContext completeTransition:finished];
        }];
    }
}

- (CGRect)frameForCircleWithViewCenter:(CGPoint)center
                                  size:(CGSize)viewSize
                            startPoint:(CGPoint)startPoint
{
    CGFloat xLength = fmax(startPoint.x, viewSize.width - startPoint.x);
    CGFloat yLength = fmax(startPoint.y, viewSize.height - startPoint.y);
    
    CGFloat offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2;
    CGSize size = CGSizeMake(offsetVector, offsetVector);
    
    return CGRectMake(CGPointZero.x, CGPointZero.y, size.width, size.height);
}

@end
