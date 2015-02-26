//
//  DetailViewController.h
//  ThinkOfYou
//
//  Created by Xiangnan Xu on 2/25/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController
- (IBAction)onBackButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) PFObject *reminder;
@end
