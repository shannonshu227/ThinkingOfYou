//
//  MainViewController.m
//  ThinkOfYou
//
//  Created by Xiangnan Xu on 2/20/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ComposeViewController.h"
#import "ProfileViewController.h"

@interface MainViewController ()

//@property (nonatomic, strong) HomeViewController *homeViewController;
//@property (nonatomic, strong) ComposeViewController *composeViewController;
//@property (nonatomic, strong) ProfileViewController *profileViewController;

@property (nonatomic, strong) UINavigationController *nvcHome;
@property (nonatomic, strong) UINavigationController *nvcNew;



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nvcHome = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    self.nvcNew = [[UINavigationController alloc] initWithRootViewController:[[ComposeViewController alloc] init]];
    
    [self.contentView addSubview:self.nvcHome.view];
    self.nvcHome.view.frame = self.contentView.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onHomeButton:(id)sender {
    NSArray *viewsToRemove = [self.contentView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    [self.contentView addSubview:self.nvcHome.view];
    self.nvcHome.view.frame = self.contentView.frame;
}

- (IBAction)onNewButton:(id)sender {
    NSArray *viewsToRemove = [self.contentView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    [self.contentView addSubview:self.nvcNew.view];
    self.nvcNew.view.frame = self.contentView.frame;
}

@end
