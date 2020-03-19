//
//  ViewController.m
//  DynamicNavigationBar
//
//  Created by 김명유 on 2020/03/16.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ViewController
{
    NSArray *_array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = @[@"Apple", @"Banana", @"Strawberry", @"blueberry", @"melon", @"watermelon", @"Grape", @"Mango"];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
//    self.navigationController.hidesBarsOnSwipe = YES;
//    self.navigationController.hidesBarsOnTap = YES;
    
    
    self.navigationItem.title = @"Fruits";
    
//    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 500);
//    view.backgroundColor = UIColor.greenColor;
//
//    self.navigationItem.titleView = view;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//}

@end
