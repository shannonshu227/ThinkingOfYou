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

@interface MainViewController ()

@property (nonatomic, strong) HomeViewController *nvcHome;
@property (nonatomic, strong) ComposeViewController *nvcNew;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nvcHome = [[HomeViewController alloc] init];
    self.nvcNew = [[ComposeViewController alloc] init];
    
    [self.contentView addSubview:self.nvcHome.view];
    self.nvcHome.view.frame = self.contentView.frame;
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
