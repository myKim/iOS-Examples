//
//  ViewController.m
//  TableViewTutorial
//
//  Created by 김명유 on 2020/03/19.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (weak, nonatomic) IBOutlet UILabel *sectionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *rowsLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedSectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedRowLabel;
@end

@implementation ViewController
{
    NSArray<NSArray *> *_array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
}

- (void)initialize
{
    _array = @[
        @[@"1-1",@"1-2",@"1-3",@"1-4",@"1-5",@"1-6",@"1-7",@"1-8",@"1-9",@"1-10"],
        @[@"2-1",@"2-2",@"2-3",@"2-4",@"2-5",@"2-6",@"2-7",@"2-8",@"2-9",@"2-10"],
        @[@"3-1",@"3-2",@"3-3",@"3-4",@"3-5",@"3-6",@"3-7",@"3-8",@"3-9",@"3-10"],
        @[@"4-1",@"4-2",@"4-3",@"4-4",@"4-5",@"4-6",@"4-7",@"4-8",@"4-9",@"4-10"],
        @[@"5-1",@"5-2",@"5-3",@"5-4",@"5-5",@"5-6",@"5-7",@"5-8",@"5-9",@"5-10"],
    ];
    
    NSInteger sections = _array.count;
    NSInteger rows = 0;
    for (NSArray *array in _array) {
        rows += array.count;
    }
    
    self.sectionsLabel.text = @(sections).stringValue;
    self.rowsLabel.text = @(rows).stringValue;
    self.selectedSectionLabel.text = @"-";
    self.selectedRowLabel.text = @"-";
}

- (IBAction)onEditButtonClicked:(id)sender {
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    
    self.editButton.title = self.tableView.isEditing ? @"Complete" : @"Edit";
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @(section + 1).stringValue;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *data = _array[indexPath.section][indexPath.row];
    cell.textLabel.text = data;
    
    return cell;
}

// Reordering Cell
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray *sourceArray = _array[sourceIndexPath.section].mutableCopy;
    
    NSMutableArray *destinationArray;
    if (sourceIndexPath.section == destinationIndexPath.section) {
        destinationArray = sourceArray;
    } else {
        destinationArray = _array[destinationIndexPath.section].mutableCopy;
    }
    
    id item = [sourceArray objectAtIndex:sourceIndexPath.row];
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    [destinationArray insertObject:item atIndex:destinationIndexPath.row];
    
    NSMutableArray *array = _array.mutableCopy;
    
    array[sourceIndexPath.section] = sourceArray;
    array[destinationIndexPath.section] = destinationArray;
    _array = array;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedSectionLabel.text = @(indexPath.section).stringValue;
    self.selectedRowLabel.text = @(indexPath.row).stringValue;
}

@end
