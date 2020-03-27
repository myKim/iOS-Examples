//
//  ViewController.m
//  CircularTransitionAnimation
//
//  Created by 김명유 on 2020/03/27.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ViewController.h"
#import "CircularTransition.h"
#import "SecondViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) CircularTransition *transition;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.button.layer.cornerRadius = self.button.frame.size.width / 2;
    _transition = [[CircularTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _transition.transitionMode = CircularTransitionModePresent;
    _transition.startingPoint = self.button.center;
    _transition.circleColor = self.button.backgroundColor;
    
    return _transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _transition.transitionMode = CircularTransitionModeDismiss;
    _transition.startingPoint = self.button.center;
    _transition.circleColor = self.button.backgroundColor;
    
    return _transition;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SecondViewController *secondViewController = segue.destinationViewController;
    secondViewController.transitioningDelegate = self;
    secondViewController.modalPresentationStyle = UIModalPresentationCustom;
}

@end
