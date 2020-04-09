//
//  CustomButton.m
//  CustomViewAutoLayoutTest
//
//  Created by 김명유 on 2020/04/05.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.backgroundColor = UIColor.greenColor;
    self.layer.borderColor = UIColor.whiteColor.CGColor;
    self.layer.borderWidth = 8.0;
    
    [self setTitle:@"완료" forState:UIControlStateNormal];
//    [self setTitle:@"하이" forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor.blackColor colorWithAlphaComponent:0.3] forState:UIControlStateHighlighted];
    
    [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(onTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(onTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    
//    for (UIGestureRecognizer *recognizer in self.window.gestureRecognizers) {
//        recognizer.delaysTouchesBegan = NO;
//    }
//
//    for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
//        recognizer.delaysTouchesBegan = NO;
//    }
    
//    self.delay
    
    
//    self actions
}


//
//override func viewDidAppear(animated: Bool) {
//    let window = view.window!
//    let gr0 = window.gestureRecognizers![0] as UIGestureRecognizer
//    let gr1 = window.gestureRecognizers![1] as UIGestureRecognizer
//    gr0.delaysTouchesBegan = false
//    gr1.delaysTouchesBegan = false
//}

- (void)onTouchDown:(UIButton *)sender
{
    NSLog(@"touch down");
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:nil];
}

- (void)onTouchUpInside:(UIButton *)sender
{
    NSLog(@"touch up inside");
    [UIView animateWithDuration:0.2 delay:0.15 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)onTouchUpOutside:(UIButton *)sender
{
    NSLog(@"touch up outside");
    [UIView animateWithDuration:0.2 delay:0.15 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)onTouchDragExit:(UIButton *)sender
{
//    NSLog(@"touch drag exit");
//    [UIView animateWithDuration:0.2 delay:0.15 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.transform = CGAffineTransformIdentity;
//    } completion:nil];
}

//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesBegan");
//    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.transform = CGAffineTransformMakeScale(0.85, 0.85);
//    } completion:nil];
//    [super touchesBegan:touches withEvent:event];
//}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesMoved");
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesEnded");
//    [UIView animateWithDuration:0.3 delay:0.2 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.transform = CGAffineTransformIdentity;
//    } completion:nil];
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesCancel");
//}

@end
