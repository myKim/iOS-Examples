//
//  ViewController.m
//  CustomNavigationBarSlideAndFade
//
//  Created by 김명유 on 2020/03/14.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

/**
 * 참고 : UIKit Custom Navigation Bar Slide and Fade (https://www.youtube.com/watch?v=F-L_AiAZ6ME)
 */

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController
{
    NSArray *_array;
    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = @[@"Apple", @"Strawberry", @"Grape", @"Banana", @"Melon", @"Watermelon", @"Cherry",
               @"Apple", @"Strawberry", @"Grape", @"Banana", @"Melon", @"Watermelon", @"Cherry",
               @"Apple", @"Strawberry", @"Grape", @"Banana", @"Melon", @"Watermelon", @"Cherry",
               @"Apple", @"Strawberry", @"Grape", @"Banana", @"Melon", @"Watermelon", @"Cherry",
               @"Apple", @"Strawberry", @"Grape", @"Banana", @"Melon", @"Watermelon", @"Cherry"];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsSelection = NO;
    
    [self setupNavigationItem];
}

- (void)setupNavigationItem
{
    // 1) Navigation Item 타이틀 텍스트 세팅
//    self.navigationItem.title = @"Navi Bar";
    
    // 2) titleView에 커스텀 뷰 세팅
    CGFloat width = self.view.bounds.size.width;
    
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, width, 50);
    titleView.backgroundColor = UIColor.yellowColor;
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.frame = CGRectMake(0, 0, width, 50);
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    [titleView addSubview:stackView];
    
    UIImage *image = [UIImage imageNamed:@"NC_logo"];
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.frame = CGRectMake(0, 0, 200, titleView.bounds.size.height);
    [stackView addArrangedSubview:_imageView];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 60, 50);
    button.titleLabel.text = @"Button";
    button.tintColor = UIColor.blackColor;
    [stackView addArrangedSubview:button];
    
    self.navigationItem.titleView = titleView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat safeAreaTop = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.top;
    
    CGFloat magicalSafeAreaTop = safeAreaTop + self.navigationController.navigationBar.frame.size.height;
    NSLog(@"%f", scrollView.contentOffset.y);
    
//    CGFloat offset = scrollView.contentOffset.y + magicalSafeAreaTop;
//    CGFloat alpha = 1 - ((scrollView.contentOffset.y + magicalSafeAreaTop) / magicalSafeAreaTop);
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = 1 + scrollView.contentOffset.y / - 50;
    
    _imageView.alpha = alpha;
    
    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, MIN(0, -offset));
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

@end
