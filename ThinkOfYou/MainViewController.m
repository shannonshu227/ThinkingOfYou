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

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainViewController ()

@property (nonatomic, strong) HomeViewController *nvcHome;
@property (nonatomic, strong) ComposeViewController *nvcNew;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nvcHome = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    self.nvcNew = [[UINavigationController alloc] initWithRootViewController:[[ComposeViewController alloc] init]];
    [self.contentView addSubview:self.nvcHome.view];
    self.nvcHome.view.frame = self.contentView.frame;
    
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
