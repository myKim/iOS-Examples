//
//  ThirdView.m
//  CustomViewAutoLayoutTest
//
//  Created by 김명유 on 2020/04/04.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ThirdView.h"

@implementation ThirdView

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
    self.backgroundColor = UIColor.cyanColor;
}

@end
