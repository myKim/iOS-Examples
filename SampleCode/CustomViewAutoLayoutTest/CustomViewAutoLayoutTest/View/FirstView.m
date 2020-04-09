//
//  FirstView.m
//  CustomViewAutoLayoutTest
//
//  Created by 김명유 on 2020/04/04.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "FirstView.h"
#import "HeaderView.h"
#import "ContentView.h"
#import "FooterView.h"
#import "UIView+AutoLayout.h"
#import "CustomButton.h"

@implementation FirstView

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
    self.backgroundColor = UIColor.orangeColor;
    
    HeaderView *header = [[HeaderView alloc] init];
    
    [self addAutoLayoutSubview:header];
    
    [self.leadingAnchor constraintEqualToAnchor:header.leadingAnchor constant:0].active = YES;
    [self.topAnchor constraintEqualToAnchor:header.topAnchor constant:-100].active = YES;
    [header.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    
    CustomButton *button = [[CustomButton alloc] init];
    button.layer.cornerRadius = 50;
    [self addAutoLayoutSubview:button];
    
    [NSLayoutConstraint activateConstraints:@[
        [button.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [button.widthAnchor constraintEqualToConstant:100],
        [button.heightAnchor constraintEqualToConstant:100],
    ]];
}

@end
