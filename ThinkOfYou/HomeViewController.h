//
//  HomeViewController.h
//  ThinkOfYou
//
//  Created by Xiangnan Xu on 2/20/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *remindersOfUser;
@property (nonatomic, strong) PFUser *currentUser;
- (id)initWithSuperID:(id) superID;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSArray *reminders;
@property (nonatomic, strong) id superClassID;
@end
