//
//  HomeViewController.m
//  ThinkOfYou
//
//  Created by Xiangnan Xu on 2/20/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "ProfileCell.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSArray *reminders;
@property (nonatomic, strong) NSMutableDictionary *remindersOfUser;
@property (nonatomic, strong) PFUser *currentUser;
@end

@implementation HomeViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"ProfileCellID"];

    self.users = [[NSArray alloc] init];
    self.remindersOfUser = [[NSMutableDictionary alloc] init];
    self.reminders = [[NSArray alloc] init];

    PFUser *currentUser = [PFUser currentUser];
    self.currentUser =currentUser;
    
    PFQuery *userQuery = [PFUser query];
    
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (!error) {
            
            // The find succeeded. The first 100 objects are available in objects
            self.users = users;
           
            PFQuery *reminderQuery = [PFQuery queryWithClassName:@"Reminder"];
            [reminderQuery findObjectsInBackgroundWithBlock:^(NSArray *reminders, NSError *error) {
                if (!error) {
                    self.reminders = reminders;
                    
                    //NSLog(@"reminders:%lu", (unsigned long)self.reminders.count);
                    for (PFUser *eachUser in self.users) {
                        NSString *name = eachUser.username;
                        
                        self.remindersOfUser[name] = [[NSMutableArray alloc] init];
                    }
                    
                    for (PFObject *reminder in self.reminders) {
                        NSString *toName = reminder[@"to"];
                        NSMutableArray *userReminderArray = [self.remindersOfUser objectForKey:toName];
                        [userReminderArray addObject:reminder];
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                } else {
                    NSLog(@"Errors: %@ %@", error, [error userInfo]);
                }
            }];

            NSLog(@"users: %lu", (unsigned long)self.users.count);
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *userReminderArray = [self.remindersOfUser objectForKey:self.currentUser.username];
    return userReminderArray.count+1;
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCellID" forIndexPath:indexPath];
        PFFile *imageFile = self.currentUser[@"profilePicture"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                cell.profileImageView.image = image;
                
            }
        }];
        cell.nameLabel.text = self.currentUser.username;
        return cell;
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
        NSMutableArray *userReminderArray = [self.remindersOfUser objectForKey:self.currentUser.username];
        PFObject *reminder = userReminderArray[indexPath.row - 1];
        NSString *fromUser = [NSString stringWithFormat:@"%@: ", reminder[@"from"]];
        NSMutableString *text = [[NSMutableString alloc] initWithString:fromUser];
        [text appendString:reminder[@"content"]];
        cell.textLabel.text = text;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 0 ) {
        return 73;
    } else {
        return 50;
    }
}

@end
