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
        
        NSString *title = @"";
        NSString *message = @"";
        
        if (success) {
            title = @"Success";
            message = [NSString stringWithFormat:@"response = %@", response];
        } else {
            title = @"Fail";
            if (error) {
                message = error.domain;
            }
        }
        [self showAlertWithTitle:title message:message];
    }];
}

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
