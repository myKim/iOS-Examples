//
//  ViewController.m
//  ExpandableAndCollapsibleSectionTableView
//
//  Created by 김명유 on 2020/03/13.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

/**
 * 참고 : Expandable and Collapsible Sections UITableView (Ep 3) https://www.youtube.com/watch?v=Q8k9E1gQ_qg
 */

#import "ViewController.h"
#import "ExpandableSectionModel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController
{
    NSArray<ExpandableSectionModel *> *_array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = @[[[ExpandableSectionModel alloc] initWithArray:@[@"apple", @"banana", @"grape", @"pineapple", @"strawberry"]
                                                  isExpanded:YES],
               [[ExpandableSectionModel alloc] initWithArray:@[@"cat", @"dog", @"lion", @"tiger", @"puma", @"chicken"]
                                                  isExpanded:YES],
               [[ExpandableSectionModel alloc] initWithArray:@[@"rose", @"Tulipa", @"Mint", @"Lilac"]
                                                  isExpanded:YES]];
}

- (void)onExpandCollapseButtonClicked:(UIButton *)sender
{
    NSInteger section = sender.tag;
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (int row=0; row<_array[section].array.count; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:indexPath];
    }
    
    _array[section].isExpanded = !_array[section].isExpanded;
    BOOL isExpanded = _array[section].isExpanded;
    
    [sender setTitle:isExpanded ? @"Close" : @"Open" forState:UIControlStateNormal];
    
//    if (isExpanded) {
//        [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    } else {
//        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
    
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimation];
}

#pragma mark - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array[section].isExpanded ? _array[section].array.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.section].array[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundColor:[UIColor.blueColor colorWithAlphaComponent:0.5f]];
    [button setTitle:@"Close" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [button addTarget:self action:@selector(onExpandCollapseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    button.tag = section;
    
    return button;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}

@end
