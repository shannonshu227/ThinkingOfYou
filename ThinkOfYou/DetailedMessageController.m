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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithUser:(NSString *)user andMessage:(NSString *)inputMesage andTimeStamp:(NSString *)timeStamp{
    DetailedMessageController *dm=[[DetailedMessageController alloc]init];
    dm.userName.text=user;
    dm.message.text=inputMesage;
    dm.timeStamp.text=timeStamp;
    return dm;
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
