//
//  APIListViewController.m
//  SDKTest
//
//  Created by 김명유 on 2019/11/09.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

#import "APIListViewController.h"

@interface APIListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation APIListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (_tableViewData.count > 0) ? _tableViewData.count : 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [((ApiSectionItem *)_tableViewData[section]) name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionApiList = [((ApiSectionItem *)_tableViewData[section]) apiItemList];
    return sectionApiList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *apiList = [((ApiSectionItem *)_tableViewData[indexPath.section]) apiItemList];
    ApiItem *apiItem = apiList[indexPath.row];
    cell.textLabel.text = apiItem.name;
    cell.detailTextLabel.text = apiItem.desc;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *apiList = [(ApiSectionItem *)_tableViewData[indexPath.section] apiItemList];
    ApiItem *apiItem = apiList[indexPath.row];
    
    [apiItem triggerAction];
}

@end
