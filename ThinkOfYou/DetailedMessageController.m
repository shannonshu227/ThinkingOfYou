//
//  DetailedMessageController.m
//  ThinkOfYou
//
//  Created by Xu He on 2/25/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "DetailedMessageController.h"

@interface DetailedMessageController ()

@end

@implementation DetailedMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Detail";
    
    NSString *fromUser = [NSString stringWithFormat:@"From: %@", self.reminder[@"from"]];
    self.userName.text = fromUser;
    self.message.text = self.reminder[@"content"];
    self.timeStamp.text = self.reminder[@"createdAt"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
