//
//  ComposeViewController.m
//  ThinkOfYou
//
//  Created by Xiangnan Xu on 2/20/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "ComposeViewController.h"
#import "MainViewController.h"
#import <Parse/Parse.h>

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *reminderTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.reminderTextView setTextColor:[UIColor lightGrayColor]];
    self.reminderTextView.text = @"Enter reminder here";
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.reminderTextView.delegate = self;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Enter reminder here"])
    {
        textView.text = @"";
    }
}

- (IBAction)onPostButton:(id)sender {
    PFObject *reminder = [PFObject objectWithClassName:@"Reminder"];
    reminder[@"to"] = self.nameField.text;
    reminder[@"from"] = [PFUser currentUser].username;
    reminder[@"content"] = self.reminderTextView.text;
    reminder[@"timestamp"] = @"now";
    
    [reminder saveInBackground];
    
    MainViewController *mvc = [[MainViewController alloc] init];
    [self presentViewController:mvc animated:YES completion:nil];

//    NSString *msg = [NSString stringWithFormat:@"%@ got your message woo", self.nameField.text];
}

@end
