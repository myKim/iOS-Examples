//
//  ViewController.m
//  AuthTest
//
//  Created by 김명유 on 2020/01/11.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ViewController.h"
#import "AuthServices.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *authProviderCodeTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onClickLoginViaButton:(id)sender
{
    NSString *authProviderCode = _authProviderCodeTextField.text ?: @"";
    
    [Auth loginViaAuthProviderCode:authProviderCode
                 completionHandler:^(BOOL success, NSDictionary *response, NSError *error) {
        NSLog(@"result : %@", response);
    }];
}

@end
