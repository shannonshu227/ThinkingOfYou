//
//  MainViewController.h
//  ThinkOfYou
//
//  Created by Xiangnan Xu on 2/20/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)onHomeButton:(id)sender;
- (IBAction)onNewButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@end
