//
//  DetailedMessageController.h
//  ThinkOfYou
//
//  Created by Xu He on 2/25/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailedMessageController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (strong, nonatomic) PFObject *reminder;
- (IBAction)onBackButton:(id)sender;


@end
