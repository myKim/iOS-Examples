//
//  SecondViewController.m
//  CircularTransitionAnimation
//
//  Created by 김명유 on 2020/03/27.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.button.layer.cornerRadius = self.button.frame.size.width / 2;
}

- (IBAction)onButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
