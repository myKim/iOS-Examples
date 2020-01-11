//
//  ContainerViewController.h
//  WebViewTest
//
//  Created by 김명유 on 2020/01/05.
//  Copyright © 2020 myungyu Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ContainerViewController;

NS_SWIFT_NAME(ContainerViewControllerDelegate)
@protocol ContainerViewControllerDelegate <NSObject>

- (void)viewControllerDidDisappear:(ContainerViewController *)viewController
                          animated:(BOOL)animated;

@end


NS_SWIFT_NAME(ContainerViewController)
@interface ContainerViewController : UIViewController

@property (nonatomic, weak, nullable) id<ContainerViewControllerDelegate> delegate;

- (void)displayChildController:(UIViewController *)childViewController;

@end

NS_ASSUME_NONNULL_END
