//
//  HomeViewController.m
//  ThinkOfYou
//
//  Created by Xiangnan Xu on 2/20/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "DetailedMessageController.h"
#import "ProfileCell.h"
#import "ContentCell.h"

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
    
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"ProfileCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"ContentCellID"];

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
        
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCellID" forIndexPath:indexPath];
        NSMutableArray *userReminderArray = [self.remindersOfUser objectForKey:self.currentUser.username];
        PFObject *reminder = userReminderArray[indexPath.row - 1];
        NSString *fromUser = [NSString stringWithFormat:@"From: %@", reminder[@"from"]];
        cell.fromLabel.text = fromUser;
        cell.contentLabel.text = reminder[@"content"];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Test");
    DetailedMessageController *dm=[[DetailedMessageController alloc]initWithUser:@"Test" andMessage:@"Test" andTimeStamp:@"Test"];
     [self.navigationController pushViewController:dm animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
=======
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 0 ) {
        return 73;
    } else {
        return 106;
    }
>>>>>>> bf16d3860c955eeca31f4870e7ddefe8d9cdbd0b
}




@end
