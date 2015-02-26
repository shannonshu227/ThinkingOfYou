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
#import "DetailedMessageController.h"
#import "ProfileCell.h"
#import "ContentCell.h"
#import <Parse/Parse.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainViewController ()<UITableViewDelegate>
@property (nonatomic, strong) HomeViewController *nvcHome;
@property (nonatomic, strong) ComposeViewController *nvcNew;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.nvcHome = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
//    self.nvcNew = [[UINavigationController alloc] initWithRootViewController:[[ComposeViewController alloc] init]];
    
    self.nvcHome = [[HomeViewController alloc] initWithSuperID:self];
    self.nvcNew = [[ComposeViewController alloc] init];

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailedMessageController *dvc = [[DetailedMessageController alloc] init];
    NSMutableArray *userReminderArray = [self.nvcHome.remindersOfUser objectForKey:self.nvcHome.currentUser.username];
    NSLog(@"%@", userReminderArray);
    PFObject *reminder = userReminderArray[indexPath.row - 1];
    dvc.reminder = reminder;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:dvc];
    nvc.navigationBar.translucent = NO;
    
    [self presentViewController:nvc animated:YES completion:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

@end
