//
//  AuthTestViewController.m
//  SDKTest
//
//  Created by 김명유 on 2019/11/09.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

#import "AuthTestViewController.h"

@interface AuthTestViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation AuthTestViewController

#pragma mark - Overrride Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [super numberOfSectionsInTableView:tableView];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [super tableView:tableView titleForHeaderInSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

# pragma mark - Private Methods

- (void)initViewController
{
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    self.tableViewData = @[[ApiSectionItem apiSectionItemWithName:@"Login"
                                                      apiItemList:@[[ApiItem apiItemWithName:@"showLogin"
                                                                                        desc:@"통합 로그인 UI를 보여줍니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickShowLogin:")],
                                                                    [ApiItem apiItemWithName:@"loginViaAuthProvider"
                                                                                        desc:@"원하는 AuthProvider로 로그인해서 서버 세션을 발급받습니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLoginViaAuthProvider:")],
                                                                    [ApiItem apiItemWithName:@"loginApple"
                                                                                        desc:@"애플로 로그인해서 AuthnToken을 발급받습니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLoginApple:")],
                                                                    [ApiItem apiItemWithName:@"loginViaApple"
                                                                                        desc:@"애플 로그인으로 서버 세션을 발급받습니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLoginViaApple:")],
                                                                    [ApiItem apiItemWithName:@"loginGoogle"
                                                                                        desc:@"구글로 로그인해서 AuthnToken을 발급받습니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLoginGoogle:")],
                                                                    [ApiItem apiItemWithName:@"loginViaGoogle"
                                                                                        desc:@"구글 로그인으로 서버 세션을 발급받습니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLoginViaGoogle:")],
                                                                    [ApiItem apiItemWithName:@"loginFacebook"
                                                                                        desc:@"페이스북으로 로그인해서 AuthnToken을 발급받습니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLoginFacebook:")],
                                                                    [ApiItem apiItemWithName:@"loginViaFacebook"
                                                                                        desc:@"페이스북 로그인으로 서버 세션을 발급받습니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLoginViaFacebook:")]]],
                           [ApiSectionItem apiSectionItemWithName:@"Logout"
                                                      apiItemList:@[[ApiItem apiItemWithName:@"logoutGoogle"
                                                                                        desc:@"구글 인증을 로그아웃 합니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLogoutGoogle:")],
                                                                    [ApiItem apiItemWithName:@"logoutFacebook"
                                                                                        desc:@"페이스북 인증을 로그아웃 합니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLogoutFacebook:")],
                                                                    [ApiItem apiItemWithName:@"logoutAll"
                                                                                        desc:@"모든 인증을 로그아웃 합니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickLogoutAll:")]]],
                           [ApiSectionItem apiSectionItemWithName:@"Translate Auth"
                                                      apiItemList:@[[ApiItem apiItemWithName:@"translateAuthStart"
                                                                                        desc:@"계정 전환을 시작합니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickTranslateAuthStart:")],
                                                                    [ApiItem apiItemWithName:@"translateAuthFinish"
                                                                                        desc:@"계정 전환을 끝냅니다."
                                                                                      target:self
                                                                                    selector:NSSelectorFromString(@"onClickTranslateAuthFinish:")]]]];
    return;
}

- (void)showAlertWithApiItem:(ApiItem *)apiItem
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:apiItem.name
                                                                             message:apiItem.desc
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - onClick Selectors

- (void)onClickShowLogin:(ApiItem *)apiItem
{
    NSLog(@"onClickShowLogin");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLoginViaAuthProvider:(ApiItem *)apiItem
{
    NSLog(@"onClickLoginViaAuthProvider");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLoginApple:(ApiItem *)apiItem
{
    NSLog(@"onClickLoginApple");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLoginViaApple:(ApiItem *)apiItem
{
    NSLog(@"onClickLoginViaApple");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLoginGoogle:(ApiItem *)apiItem
{
    NSLog(@"onClickLoginGoogle");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLoginViaGoogle:(ApiItem *)apiItem
{
    NSLog(@"onClickLoginViaGoogle");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLoginFacebook:(ApiItem *)apiItem
{
    NSLog(@"onClickLoginFacebook");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLoginViaFacebook:(ApiItem *)apiItem
{
    NSLog(@"onClickLoginViaFacebook");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLogoutGoogle:(ApiItem *)apiItem
{
    NSLog(@"onClickLogoutGoogle");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLogoutFacebook:(ApiItem *)apiItem
{
    NSLog(@"onClickLogoutFacebook");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickLogoutAll:(ApiItem *)apiItem
{
    NSLog(@"onClickLogoutAll");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickTranslateAuthStart:(ApiItem *)apiItem
{
    NSLog(@"onClickTranslateAuthStart");
    [self showAlertWithApiItem:apiItem];
}

- (void)onClickTranslateAuthFinish:(ApiItem *)apiItem
{
    NSLog(@"onClickTranslateAuthFinish");
    [self showAlertWithApiItem:apiItem];
}

@end
