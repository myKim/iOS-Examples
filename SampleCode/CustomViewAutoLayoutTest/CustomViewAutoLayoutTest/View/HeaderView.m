//
//  HeaderView.m
//  CustomViewAutoLayoutTest
//
//  Created by 김명유 on 2020/04/04.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "HeaderView.h"
#import "UIView+AutoLayout.h"

@implementation HeaderView

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
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"데드리프트";
    titleLabel.font = [UIFont systemFontOfSize:24];
    
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.text = @"운동";
    subtitleLabel.font = [UIFont systemFontOfSize:12];
    
    [self addAutoLayoutSubviews:@[titleLabel, subtitleLabel]];
    
    [self.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor constant:-20].active = YES;
    [self.topAnchor constraintEqualToAnchor:titleLabel.topAnchor constant:-20].active = YES;
    
    [self.leadingAnchor constraintEqualToAnchor:subtitleLabel.leadingAnchor constant:-20].active = YES;
    [titleLabel.bottomAnchor constraintEqualToAnchor:subtitleLabel.topAnchor constant:-5].active = YES;
    [subtitleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20].active = YES;
}

@end
