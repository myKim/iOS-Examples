//
//  APIListViewController.h
//  SDKTest
//
//  Created by 김명유 on 2019/11/09.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiItem.h"
#import "ApiSectionItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIListViewController : UIViewController
#pragma mark - Properties
@property (nonatomic, strong) NSArray<ApiSectionItem *> *tableViewData;

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
