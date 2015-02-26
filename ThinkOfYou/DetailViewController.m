//
//  DetailViewController.m
//  ThinkOfYou
//
//  Created by Jatin Pandey on 2/25/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "DetailViewController.h"
#import <Parse/Parse.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fromNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fromNameLabel.text = @"Jatin Pandey";
    [self.contentTextView setTextColor: [UIColor whiteColor]];
    [self.contentTextView setFont:[UIFont boldSystemFontOfSize:40]];
    self.contentTextView.text = @"Remember to get up early";
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

@end
