//
//  ViewController.m
//  CardViewAnimationTutorial
//
//  Created by 김명유 on 2020/03/04.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

// https://www.youtube.com/watch?v=L-f1KSPKm4I

#import "ViewController.h"
#import "CardViewController.h"

typedef NS_ENUM(NSInteger, CardState) {
    CardStateExpanded,
    CardStateCollapsed
};

static const CGFloat cardHeight = 600;
static const CGFloat cardHandleAreaHeight = 65;

@interface ViewController ()

@property (nonatomic, strong) CardViewController *cardViewController;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;

@property (nonatomic, assign) BOOL cardVisible;
@property (nonatomic, readonly) CardState nextState;

@property (nonatomic, strong) NSMutableArray <UIViewPropertyAnimator *> *runningAnimations;
@property (nonatomic, assign) CGFloat animationProgressWhenInterrupted;

@end

@implementation ViewController


- (CardState)nextState
{
    return _cardVisible ? CardStateCollapsed : CardStateExpanded;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInit];
    [self setupCard];
}

- (void)commonInit
{
    self.cardVisible = NO;
    self.animationProgressWhenInterrupted = 0;
    self.runningAnimations = [NSMutableArray new];
}

- (void)setupCard
{
    self.visualEffectView = [[UIVisualEffectView alloc] init];
    self.visualEffectView.frame = self.view.frame;
    [self.view addSubview:self.visualEffectView];
    
    self.cardViewController = [[CardViewController alloc] initWithNibName:@"CardViewController" bundle:nil];
    [self addChildViewController:self.cardViewController];
    [self.view addSubview:self.cardViewController.view];
    
    self.cardViewController.view.frame = CGRectMake(0, self.view.frame.size.height - cardHandleAreaHeight, self.view.bounds.size.width, cardHeight);
    
    self.cardViewController.view.clipsToBounds = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardTapRecognizer:)];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleCardPanRecognizer:)];
    
    [self.cardViewController.handleArea addGestureRecognizer:tapGestureRecognizer];
    [self.cardViewController.handleArea addGestureRecognizer:panGestureRecognizer];

    
}

- (void)handleCardTapRecognizer:(UITapGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded: {
            [self animateTransitionIfNeededWithState:self.nextState duration:0.9];
            break;
        }
        default:
            break;
    }
}

- (void)handleCardPanRecognizer:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            // strat Transition
            [self startInteractiveTransitionWithState:self.nextState duration:0.9];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // update Transition
            CGPoint translation = [recognizer translationInView:self.cardViewController.handleArea];
            CGFloat fractionComplete = translation.y / cardHeight;
            fractionComplete = self.cardVisible ? fractionComplete : -fractionComplete;
            [self updateInteractiveTransitionWithFractionCompleted:fractionComplete];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            // continue Transition
            [self continueInteractiveTransition];
            break;
        }
        default:
            break;
    }
}

- (void)animateTransitionIfNeededWithState:(CardState)state
                                  duration:(NSTimeInterval)duration
{
    if (self.runningAnimations.count == 0) {
        UIViewPropertyAnimator *frameAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:duration dampingRatio:1 animations:^{
            switch (state) {
                case CardStateExpanded: {
                    CGRect frame = self.cardViewController.view.frame;
                    frame.origin.y = self.view.frame.size.height - cardHeight;
                    self.cardViewController.view.frame = frame;
                    
                    break;
                }
                case CardStateCollapsed: {
                    CGRect frame = self.cardViewController.view.frame;
                    frame.origin.y = self.view.frame.size.height - cardHandleAreaHeight;
                    self.cardViewController.view.frame = frame;
                    break;
                }
            }
        }];
        
        [frameAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
            self.cardVisible = !self.cardVisible;
            [self.runningAnimations removeAllObjects];
        }];
        
        [frameAnimator startAnimation];
        [self.runningAnimations addObject:frameAnimator];
        
        
        UIViewPropertyAnimator *cornerRadiusAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:duration curve:UIViewAnimationCurveLinear animations:^{
            switch (state) {
                case CardStateExpanded: {
                    self.cardViewController.view.layer.cornerRadius = 12;
                    break;
                }
                case CardStateCollapsed: {
                    self.cardViewController.view.layer.cornerRadius = 0;
                    break;
                }
            }
        }];
        
        [cornerRadiusAnimator startAnimation];
        [self.runningAnimations addObject:cornerRadiusAnimator];
        
        UIViewPropertyAnimator *blurAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:duration dampingRatio:1 animations:^{
            switch (state) {
                case CardStateExpanded: {
                    self.visualEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                    break;
                }
                case CardStateCollapsed: {
                    self.visualEffectView.effect = nil;
                    break;
                }
            }
        }];
        
        [blurAnimator startAnimation];
        [self.runningAnimations addObject:blurAnimator];
    }
}

- (void)startInteractiveTransitionWithState:(CardState)state
                                   duration:(NSTimeInterval)duration
{
    if (self.runningAnimations.count == 0) {
        // run animations
        [self animateTransitionIfNeededWithState:state duration:duration];
    }
    
    for (UIViewPropertyAnimator *animator in self.runningAnimations) {
        [animator pauseAnimation];
        self.animationProgressWhenInterrupted = animator.fractionComplete;
    }
}

- (void)updateInteractiveTransitionWithFractionCompleted:(CGFloat)fractionCompleted
{
    for (UIViewPropertyAnimator *animator in self.runningAnimations) {
        animator.fractionComplete = fractionCompleted + self.animationProgressWhenInterrupted;
    }
}

- (void)continueInteractiveTransition
{
    for (UIViewPropertyAnimator *animator in self.runningAnimations) {
        [animator continueAnimationWithTimingParameters:nil durationFactor:0];
    }
}

@end
